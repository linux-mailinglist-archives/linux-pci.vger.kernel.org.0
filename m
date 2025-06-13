Return-Path: <linux-pci+bounces-29653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D9AD85F1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0413D189911D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9503C279DA4;
	Fri, 13 Jun 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/meLyf7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3212DA77F;
	Fri, 13 Jun 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804508; cv=none; b=f75pSRcI071eBghbe85tS+1Gm8qWjS6CkJi4Voa1bgqVBxy5gvGysjZnKNQMljVCBoc1iuxsUUUawpHEVgFw7KUnrluA++Vm9trBIuZkFvPl1a2/g5+/PyYnw07MVZc0ub/9GCK8aSPc3trH52ZRPChlU20wtbOYQBa2eoF97To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804508; c=relaxed/simple;
	bh=O7k/4Pgn8A5nTO/mi5w7P4nJ4sG7zxwFfsGVf+oO26Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5+yJEvV2rXHcMxApAsBJDYBL1rS20d1FM0TPHOTJxb6zQB0KB/wgSnUtCrLqDgkvRWO0YQXCtf64n5djUPjlFSa7pwy/mOI1LG2eIgDcYmtX4HnPexy6DdnjIjpxXak8q6RtEHpasV7zbU5zdWClf4oSUGBvgIN913sfntA+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/meLyf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DB2C4CEEB;
	Fri, 13 Jun 2025 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749804507;
	bh=O7k/4Pgn8A5nTO/mi5w7P4nJ4sG7zxwFfsGVf+oO26Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/meLyf7/VqgXC6zV62+515BR00HaMPB9Y4WA4AxXnYeX3NHDi3cJ7jG+sgvdTNsz
	 q9zDO4Be/fER25kId/NYYVOZlP/XdiDLXIfsLs/1VjnqIFouY50+Qwb0OSNYXIq5kE
	 LSmM7QhTjtohiR5+lYI40rHfKxEQ3/k9tWqDkvvsKyOzf8BBheDbzN9VfgcdMz/014
	 CJdKev21jV45+Ymf0I3AhrI2jFw2JJ5HSSuVvY5bB7nGUcSoqvOc4xKqApyp11LrME
	 +sMJo6s9lRuzKZMUWG8NbypSVxQXRgxNNsDTsQ7l2gzTHQmu+YkrGcdNfSGqLIS3U8
	 b5YAp90OozQjQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Hans Zhang <18255117159@163.com>
Cc: ilpo.jarvinen@linux.intel.com,
	jhp@endlessos.org,
	daniel.stodden@gmail.com,
	ajayagarwal@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Use boolean type for aspm_disabled and aspm_force
Date: Fri, 13 Jun 2025 14:18:15 +0530
Message-ID: <174980448910.32070.2549853564061158337.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250517154939.139237-1-18255117159@163.com>
References: <20250517154939.139237-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 17 May 2025 23:49:39 +0800, Hans Zhang wrote:
> The aspm_disabled and aspm_force variables are used as boolean flags.
> Change their type from int to bool and update assignments to use
> true/false instead of 1/0. This improves code clarity.
> 
> 

Applied, thanks!

[1/1] PCI/ASPM: Use boolean type for aspm_disabled and aspm_force
      commit: 7a04f18b95bdefdc8d976ccc8a4c0443b460039a

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

