Return-Path: <linux-pci+bounces-44745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA44D1F9EC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D6A7300284B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05717318157;
	Wed, 14 Jan 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQLFH3xu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C288314D0B
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403294; cv=none; b=gRzXvsSyVcRcaQEj3XtQUWDvFcvHYdyr8IoJFhkxi+zkeVizfmt+FlWTfd+qrL7KRv0yQxILQyCyDt5yaU6+WfcORpCUqxhedTaFA5OSxKX+FRky4dTp7jw148MqXtdt1OQB0AtowdENVvS5dPrgLkC3Fd0ESB1zDFttV+cGbNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403294; c=relaxed/simple;
	bh=5Zgn/FdDJ/RHAxYsGMno2WA/0mpiSPbY/AfEdxsaGko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYYM6/rcsgJDKthjDmejestZqGJbs9aYElxGG9u1x/FEF1uaJrIecTtS+6RRmiU4qNEnDI5WLDzXjllC1XIRlvdsUmmlHGIlRNAKOCC5EP/7Etu7rUWSD3UlC0kR0rAL3mC9UxEXtBwHyIkiul4puSmteb5RgZRKpYqV0srLlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQLFH3xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6B3C4CEF7;
	Wed, 14 Jan 2026 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768403293;
	bh=5Zgn/FdDJ/RHAxYsGMno2WA/0mpiSPbY/AfEdxsaGko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQLFH3xuWEDji9Az1Rx22skaM5XjKDAyZgvtqvZolk28meJ8/Wge85W7qWV3zt7QG
	 Wbv7nQWo2z6tjW+bL4UVE97Khdj8OBXBLRzqJRtGKElbJXP+kMn7EWGtLVni6JSdXM
	 ZefYxpwmXpUcnfQ4IqxSAlzlvV34nO+tKgvBCn9mxbMxJOjHoqNCKEcl87CANpboow
	 mSyUgGJaFDi8iDfgZI/vf+ljeGaLzTfbKK7WA+qOCHaRgdrpsncUdiMPpEvWqqpTVe
	 1ARVkDZKgdZQcvM8JXQanhs8vGxc5vNunvnk1nPDITi6+BDKWWSuKM5urMopUIimbN
	 r0odY1XjTfLTw==
Message-ID: <34356998-031f-4ab4-8276-02fe5e4a47fc@kernel.org>
Date: Wed, 14 Jan 2026 09:08:12 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Enable Bus Master in pci_power_up()
To: Lukas Wunner <lukas@wunner.de>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, rafael@kernel.org,
 kengyu@lexical.tw, Matthew Ruffell <matthew.ruffell@canonical.com>,
 linux-pci@vger.kernel.org
References: <20260113205626.127337-1-superm1@kernel.org>
 <aWdnWpqWQjNYKfpV@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aWdnWpqWQjNYKfpV@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 3:52 AM, Lukas Wunner wrote:
> On Tue, Jan 13, 2026 at 02:56:14PM -0600, Mario Limonciello (AMD) wrote:
>> +++ b/drivers/pci/pci.c
>> @@ -1323,6 +1323,7 @@ int pci_power_up(struct pci_dev *dev)
>>   		return -EIO;
>>   	}
>>   
>> +	pci_set_master(dev);
>>   	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>   	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>   		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
> 
> So any device will be allowed to write to memory from the get-go?

Well so I did a quick check on a modern production Strix laptop with 
6.19-rc5 on my desk with this:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..74d7745c185c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1305,6 +1305,7 @@ int pci_power_up(struct pci_dev *dev)
         bool need_restore;
         pci_power_t state;
         u16 pmcsr;
+       u16 old_cmd;

         platform_pci_set_power_state(dev, PCI_D0);

@@ -1352,6 +1353,10 @@ int pci_power_up(struct pci_dev *dev)
                 udelay(PCI_PM_D2_DELAY);

  end:
+       pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
+       pci_info(dev, "Bus mastering bit is %sabled in D0\n",
+                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");
+
         dev->current_state = PCI_D0;
         if (need_restore)
                 return 1;

Here's what I observe.

$ sudo dmesg | grep mastering
[    2.560916] pci 0000:00:01.1: Bus mastering bit is enabled in D0
[    2.580832] pci 0000:00:01.2: Bus mastering bit is enabled in D0
[    2.594468] pci 0000:00:02.1: Bus mastering bit is enabled in D0
[    2.595439] pci 0000:00:02.2: Bus mastering bit is enabled in D0
[    2.596292] pci 0000:00:02.3: Bus mastering bit is enabled in D0
[    2.597235] pci 0000:00:02.4: Bus mastering bit is enabled in D0
[    2.600120] pci 0000:00:08.1: Bus mastering bit is enabled in D0
[    2.600899] pci 0000:00:08.2: Bus mastering bit is enabled in D0
[    2.601535] pci 0000:00:08.3: Bus mastering bit is enabled in D0
[    2.610333] pci 0000:c1:00.0: Bus mastering bit is enabled in D0
[    2.611717] pci 0000:c2:00.0: Bus mastering bit is disabled in D0
[    2.612795] pci 0000:c3:00.0: Bus mastering bit is disabled in D0
[    2.613959] pci 0000:c4:00.0: Bus mastering bit is enabled in D0
[    2.621622] pci 0000:c5:00.0: Bus mastering bit is enabled in D0
[    2.624022] pci 0000:c5:00.1: Bus mastering bit is disabled in D0
[    2.624697] pci 0000:c5:00.2: Bus mastering bit is disabled in D0
[    2.629270] pci 0000:c5:00.4: Bus mastering bit is enabled in D0
[    2.634864] pci 0000:c5:00.5: Bus mastering bit is disabled in D0
[    2.635657] pci 0000:c5:00.7: Bus mastering bit is disabled in D0
[    2.636505] pci 0000:c6:00.0: Bus mastering bit is disabled in D0
[    2.636859] pci 0000:c6:00.1: Bus mastering bit is disabled in D0
[    2.641870] pci 0000:c7:00.0: Bus mastering bit is enabled in D0
[    2.649681] pci 0000:c7:00.3: Bus mastering bit is enabled in D0
[    2.657457] pci 0000:c7:00.4: Bus mastering bit is enabled in D0
[    2.665211] pci 0000:c7:00.5: Bus mastering bit is enabled in D0
[    2.669811] pci 0000:c7:00.6: Bus mastering bit is enabled in D0
[    5.114596] pcieport 0000:00:01.1: Bus mastering bit is enabled in D0
[    5.170824] pcieport 0000:00:01.2: Bus mastering bit is enabled in D0
[    8.025850] snd_hda_intel 0000:c5:00.1: Bus mastering bit is disabled 
in D0
[   22.314165] pcieport 0000:00:02.4: Bus mastering bit is enabled in D0
[   22.330193] r8169 0000:c4:00.0: Bus mastering bit is enabled in D0
[   22.336309] xhci_hcd 0000:c7:00.0: Bus mastering bit is disabled in D0
[   34.587505] snd_hda_intel 0000:c5:00.1: Bus mastering bit is enabled 
in D0
[   35.771050] xhci_hcd 0000:c5:00.4: Bus mastering bit is disabled in D0

So doesn't BIOS appear to have set bus mastering on a majority of 
devices already?

> That sounds like a very bad idea.  For security reasons alone,
> we only want to enable bus mastering when needed.  

Should actually be doing the reverse of my proposed patch and explicitly 
disabling bus mastering in the PCI core at startup then require drivers 
to set policy?

> It's up to
> the driver to enable it, not up to the PCI core.  We've had cases
> in the past where devices corrupted memory because BIOS left
> bus mastering enabled, see abb2bafd295f.  Enabling bus mastering
> for everything anytime will exacerbate such problems or uncover
> new ones.
> 

How do you feel about the other proposal I mentioned, not clearing it on 
kexec?  Matthew confirmed this will help this issue too.

