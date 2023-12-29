Return-Path: <linux-pci+bounces-1546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E781FEE8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194C4282A3C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038410960;
	Fri, 29 Dec 2023 10:32:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sender3-of-o58.zoho.com (sender3-of-o58.zoho.com [136.143.184.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73B10A18;
	Fri, 29 Dec 2023 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5challer.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=5challer.de
ARC-Seal: i=1; a=rsa-sha256; t=1703845887; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZUz0ophMe7kgZIWKtgfj94N1g38oksyaOO+kyH+GdzmMhj/bl4OIlDwJ4H+5SN3R4WAcvDhj/2BDajZlnfRd13BL5tY/phuawK/B11KQ3mEdIJTbHLsNO+tu6P2OlP69RFrhlnrvV2EllasZ/5zwDTWBQGFjnItFUMpWNgBmt04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1703845887; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rg4b2H0xR+jbn+tpScalYKC7YWYLn3R6QTfq1ObkVf0=; 
	b=VAYfQAjTKJ4mQ2AKytqxCLR05AWmBCcEeo1zppulN3h8LdRBM9LI74nTYOM+j2mc58H8tpZKrIkvVEcnCl+HZuwsYDUGcgksH/3r8uaMzx5eR0ue2xCIWJzXlPl6T9wEir6Ibq4NcHqOzuJCgtJTM1FkTfcAMDWD+qL2v63P/vc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=michael@5challer.de;
	dmarc=pass header.from=<michael@5challer.de>
Received: from [192.168.144.187] (ipbcc11913.dynamic.kabel-deutschland.de [188.193.25.19]) by mx.zohomail.com
	with SMTPS id 1703845885553228.68119821986124; Fri, 29 Dec 2023 02:31:25 -0800 (PST)
Message-ID: <a83ad70d-910e-4bb4-97c8-008dc74526c4@5challer.de>
Date: Fri, 29 Dec 2023 11:31:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kai.heng.feng@canonical.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, macro@orcam.me.uk, ajayagarwal@google.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, gregkh@linuxfoundation.org,
 hkallweit1@gmail.com, michael.a.bottini@linux.intel.com,
 johan+linaro@kernel.org, "David E. Box" <david.e.box@linux.intel.com>
References: <20231229002623.GA1560896@bhelgaas>
Content-Language: en-US
From: Michael Schaller <michael@5challer.de>
In-Reply-To: <20231229002623.GA1560896@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

> Hi Michael, thank you very much for debugging and reporting this!
> Sorry for the major inconvenience.
> 
You're welcome and the only inconvenience was doing the bisect. ;-)

> We have some known issues with saving and restoring ASPM state on
> suspend/resume, in particular with ASPM L1 Substates, which are
> enabled on this device.
> 
> David Box has a patch in the works that should fix one of those
> issues:
> https://lore.kernel.org/r/20231221011250.191599-1-david.e.box@linux.intel.com
> 
> It's not merged yet, but it's possible it might fix or at least be
> related to this.  If you try it out, please let us know what happens.
> 
I gave the proposed patch a quick test on top of kernel 6.6.8 and it 
didn't affect this issue (the reboot still happens on resume attempt).

