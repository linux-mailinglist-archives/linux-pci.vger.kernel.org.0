Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17441C57F3
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgEEOD5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 5 May 2020 10:03:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55420 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgEEODO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 10:03:14 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVy7v-0000Zp-BP
        for linux-pci@vger.kernel.org; Tue, 05 May 2020 14:00:51 +0000
Received: by mail-pj1-f69.google.com with SMTP id o6so2658439pjl.1
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2020 07:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tmt1kAkSNgDDA6SgCoiKzqt8Vdok8wOVXa0LwLlOOZU=;
        b=dXnzd3ylYrmtmWHZYe6EOBKmCy4wxaQA1exCUjgG+fCLM2OMoevPsO+xul9jwNUzDE
         31pvvDF3Y2vKIs0Ek1zoiDFNJYb0bzacbQDDKuDVMYVy1Ms1a20DHX0fLBh90fd4OQtB
         xInhoNXr2AZMF9EdFNFELX2YeHLYPWWITym7vNRwSF137Dc8sHK4uGqavgTSIC2KSJdb
         jL0hz7S4W6l7A0C+c2B2qJ4rozSRHDR8AMt+ejHq5I8YbY/s3ic30DBWJ9NdM+6Qys5n
         yz9OpN4Tw1aO9IeWd5LXx2OFQ3al85P2oI69Ev/Kso1iOts0DLfeBXOPq4oYj6WzL7Of
         i7ww==
X-Gm-Message-State: AGi0PuZUBHy6auHrOTZ8mg+Qo48NLZn9onhGFVsNgjZtUR3k/EoJ6CjX
        egspcXzY18DhCBm4sBqvQyycgfoGYuWP3/nm62U+0QH0wOZ/pEU61KUvfE70mNvqUCeH0+yvVdK
        Fzj9jHkwTF/0lwYDLVi+t/fLJmtjG9LDVQ0qimg==
X-Received: by 2002:a17:902:ea86:: with SMTP id x6mr2988472plb.75.1588687248903;
        Tue, 05 May 2020 07:00:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoro7cEao2ONYO3zXMXFh9sQspXjrC68hvKiS5R86yKK21qYdpckzfRBbNmL5QHsMRvuIvAA==
X-Received: by 2002:a17:902:ea86:: with SMTP id x6mr2988449plb.75.1588687248460;
        Tue, 05 May 2020 07:00:48 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z60sm2236850pjj.14.2020.05.05.07.00.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:00:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] PCI/ASPM: Enable ASPM for root complex <-> bridge <->
 bridge case
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200505133812.GA353121@bjorn-Precision-5520>
Date:   Tue, 5 May 2020 22:00:44 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B6977248-C345-466D-AE8B-600088B73FA8@canonical.com>
References: <20200505133812.GA353121@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On May 5, 2020, at 21:38, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Tue, May 05, 2020 at 08:27:59PM +0800, Kai-Heng Feng wrote:
>> The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
>> state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
>> power. On Windows ASPM L1 is enabled on the device and its upstream
>> bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
>> power.
> 
> The above is a benefit, but leading off with it suggests that this
> change is specifically for that config, which it isn't.

Yes, it applies all devices that meet the condition.

> 
>> Currently, ASPM is disabled if downstream has bridge function. It was
>> introduced by commit 7d715a6c1ae5 ("PCI: add PCI Express ASPM support").
>> The commit introduced PCIe ASPM support, but didn't explain why ASPM
>> needs to be in that case.
> 
> s/needs to be in that case/needs to be disabled in that case/ ?

Yes indeed I missed that word...

> 
>> So relax the condition a bit to let bridge which connects to root
>> complex enables ASPM, instead of removing it completely, to avoid
>> regression.
> 
> If this is a regression, that means it used to work correctly.  So are
> you saying 7d715a6c1ae5^ works correctly?  That seems doubtful since
> 7d715a6c1ae5 appeared in v2.6.26 and added ASPM support in the first
> place.

Clearly I didn't express my intention well enough.
What I meant was, we can either remove the "disable ASPM on bridge" case completely, or do what this patch does.

> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/pci/pcie/aspm.c | 14 ++++++++------
>> 1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 2378ed692534..af5e22d78101 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -629,13 +629,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>> 	/* Setup initial capable state. Will be updated later */
>> 	link->aspm_capable = link->aspm_support;
>> 	/*
>> -	 * If the downstream component has pci bridge function, don't
>> -	 * do ASPM for now.
> 
> I agree, that comment is missing the essential information about *why*
> we don't do ASPM.

Or missing a part to re-enable ASPM in later time.

> 
>> +	 * If upstream bridge isn't connected to root complex and the
>> +	 * downstream component has pci bridge function, don't do ASPM for now.
> 
> But this comment just perpetuates it and makes the special case even
> more special.  I think we should either remove that special case
> completely or figure out what the real issue is.

I do prefer remote it completely, but I was afraid of introducing any regression so I just made the case more "special".

> 
> I know we weren't always very good about computing the acceptable
> latencies (and we still don't handle LTR correctly, though that's an
> L1 Substates issue that wouldn't have applied in the 7d715a6c1ae5
> timeframe).

Seems like Windows doesn't disable ASPM on bridge to bridge case, can we take the risk and remove the special case completely?

Kai-Heng

> 
>> 	 */
>> -	list_for_each_entry(child, &linkbus->devices, bus_list) {
>> -		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
>> -			link->aspm_disable = ASPM_STATE_ALL;
>> -			break;
>> +	if (parent->bus->parent) {
>> +		list_for_each_entry(child, &linkbus->devices, bus_list) {
>> +			if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
>> +				link->aspm_disable = ASPM_STATE_ALL;
>> +				break;
>> +			}
>> 		}
>> 	}
>> 
>> -- 
>> 2.17.1

