Return-Path: <linux-pci+bounces-23474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203EA5D7CB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8F53B68B3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F051D230277;
	Wed, 12 Mar 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faaq5wd1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713423024D;
	Wed, 12 Mar 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766808; cv=none; b=KZVhRzxsMatEms8fDv+IRS9/kIfIMjOEYMbDMFUWb+fVVarCHIgUWVPiOsuE5TcpZO2dLLtotyAK5akLq5VFaIFQWKCO/M7VdoHae9X+chNstMrgCEPg/yJrfqMNbpRo7/BPePLGFuZ7XcI3iWskcwZGi3W61ePIba+vP/qMPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766808; c=relaxed/simple;
	bh=2qYWFd2AX/MDpzQluHIJXRZMEf7QU64v1QrPYF0Aleg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REjEdPYX0FqytNUisCs15C9qsfVr4nqReZo0GQuJdPEdcGAocLZi+RyoIa03QlSCOVwt2imYytuLtR7Mkc9iyNigU4H0ZIP3wDr3oRHpNsWz1RUPpkltRRrkYzwGGLviPvUxACK8W2XPAoIR6BL2dQIqgu4IsjH5isle4HBuDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faaq5wd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A053C4CEE3;
	Wed, 12 Mar 2025 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741766808;
	bh=2qYWFd2AX/MDpzQluHIJXRZMEf7QU64v1QrPYF0Aleg=;
	h=From:To:Cc:Subject:Date:From;
	b=faaq5wd1LWhr3FeNtx4FIJvQ7eJLxpJTnZ7gPJy1HX3IidTpawbto0XNePn8N2jgm
	 lt0ZIyl4zHz03FraSJcFt7fuvcC0klbFNeE1cJej6R4NSqUACE+yTe7xSXpSfN5aKd
	 ASA4NkzvozTrXjuXA6xi+rPK/ixgj8z8IQJjikuBlAMRN19ObFufGS3Buz/ZYRyX28
	 hd+lifDDKo1u9DSae6ZDBVOXXHhbpCDQNt4OObW44E5Pzz6jRALZFst9WEm2Rmyard
	 NWhpj+AsLyYYlRhxBarOhCaOuUo0zWa1T0tlJmGB74ABcNGHX23K6gMWCHd9F1PQG5
	 P38wVYEMSVMiw==
From: Philipp Stanner <phasta@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v3 0/2] Harden PCI resource array indexing
Date: Wed, 12 Mar 2025 09:06:33 +0100
Message-ID: <20250312080634.13731-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a v3, spiritually successing "v1" the original implementation of
length checking [1], and "v2", the fix squashed in by Krzyzstof [2].

Changes in v3:
  - Use PCI_NUM_RESOURCES as the devres array length and provide that as
    a bugfix to be backported. (Damien)

[1] https://lore.kernel.org/linux-pci/20250304143112.104190-2-phasta@kernel.org/
[2] https://lore.kernel.org/linux-pci/20250305075354.118331-2-phasta@kernel.org/

Philipp Stanner (2):
  PCI: Fix wrong length of devres array
  PCI: Check BAR index for validity

 drivers/pci/devres.c | 18 +++++++++++++++---
 drivers/pci/iomap.c  | 29 +++++++++++++++++++++--------
 drivers/pci/pci.c    |  6 ++++++
 drivers/pci/pci.h    | 16 ++++++++++++++++
 4 files changed, 58 insertions(+), 11 deletions(-)

-- 
2.48.1


