Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9D3CAED6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 00:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhGOWDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 18:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhGOWDH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 18:03:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4ADDC60FE7;
        Thu, 15 Jul 2021 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386413;
        bh=kj3NB8eAH5vyZkGvBvAiH4DG+lhRbbxNR5j5r/qhffQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4ZJTx2n8l/vzVNArCdFK7VhR4YaIhMnLHgzqXc9oU7DWDl6yYv/Cg2YoTi/XdOcS
         PQxNjzsV9yB6DoMIcvMtcI/t1Uj0jKlNEbverb+2VYYE3oZXrgJa0CWWbVbD+VSVRn
         zzvuH/iu5KUkXoC2nWim05IJcSvU2LO/2xKG6mcg4xqacS/wdhB2cEoWEP1k6xdVEr
         GU0yvEDyTpT3ecMPBpuTNkCpwCVdvw4bAYukckO8wpoOfp084SoBIaugY/IAseRwNC
         C2KXnjZbOch09Z04VW9ZqnVHOhSzuGYg110TcOd2CVQSuU5rLnfkxfVTUvc2ZUK0Xl
         HSyDOaz2SrKhQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/5] PCI/VPD: pci_vpd_size() cleanups
Date:   Thu, 15 Jul 2021 16:59:54 -0500
Message-Id: <20210715215959.2014576-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is a follow-up to the conversation here:
https://lore.kernel.org/r/1cdda5f1-e1ea-af9f-cfbe-952b7d37e246@gmail.com
about how and whether we should validate the contents of VPD.

My proposal is to basically do minimal validation since the kernel really
doesn't care about the actual *contents* of VPD and mainly provides an
access mechanism (although there a few drivers that get part numbers and
maybe even clocking information from VPD).

I welcome any feedback!

Bjorn Helgaas (5):
  PCI/VPD: Correct diagnostic for VPD read failure
  PCI/VPD: Check Resource tags against those valid for type
  PCI/VPD: Consolidate missing EEPROM checks
  PCI/VPD: Don't check Large Resource types for validity
  PCI/VPD: Allow access to valid parts of VPD if some is invalid

 drivers/pci/vpd.c | 63 +++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

-- 
2.25.1

