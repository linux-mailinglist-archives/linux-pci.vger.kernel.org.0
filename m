Return-Path: <linux-pci+bounces-13259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740BC97AEAE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 12:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770F2B229C1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE915F308;
	Tue, 17 Sep 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qk+IN80N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VXYMTNr+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qk+IN80N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VXYMTNr+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41215B14F;
	Tue, 17 Sep 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568680; cv=none; b=VmEjtuFGqDnGLe/TE4CWdLEaOQHpfhMxEvHsLSPbOFdiuxu9HY3LlbfcLJNvgEyfreFWxcdg4JzJdyJ9ZTdCjkaXkeTZALCsvMPjYGaDjBKSjRTLn4UgfNQuh9iyqt84hZ7/39kWLPizO/WaVbIIis6kUkiPek58jQoCMiKrSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568680; c=relaxed/simple;
	bh=eyT1OtP54UlgVcI+m5y0AaA0jFcpYLcpfC+GsNQLgRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjQQZJCxH7K2Bos5/Qw/olCl6Has0I9Nfoq5pH4orwMHx/jLNinjW5R5BrQsvWdqDHm9BtCeF3MN/mqIecafE/btE8DMp5L6KujcEF7UnXlIq/ETBxKebBmHp2ITiGziIJ1gvvJEtRaj78pSuKjb0/OOI4QwGnHHYSjuKP8gtY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qk+IN80N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VXYMTNr+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qk+IN80N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VXYMTNr+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5274C20006;
	Tue, 17 Sep 2024 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726568676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuGWZnD6p9BvXmL4N0uz16mbensRF2aEqhxw/6Os88g=;
	b=Qk+IN80NjcPI5QJAMLDj4yio/ttB+54eP768tXylVeUCr5JxKeax765lDaRdBbxXksm9sU
	V/3oVBnNB+LKp7YUhTb5vkt0m/dc24PiqcJ7FjkOSb856+3YFYTGHkkKgG4/RH4G2CxEQ8
	FA4jOjSBLq3v9fwZtntrR6UbzjjQPR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726568676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuGWZnD6p9BvXmL4N0uz16mbensRF2aEqhxw/6Os88g=;
	b=VXYMTNr+RcGPMnM1ZA81h1IkQtdcFx01Ht1PQkf+xzrDTit8gjjgDgRS86naZpsBk65KSl
	jSUvF/oTQpVVXXCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726568676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuGWZnD6p9BvXmL4N0uz16mbensRF2aEqhxw/6Os88g=;
	b=Qk+IN80NjcPI5QJAMLDj4yio/ttB+54eP768tXylVeUCr5JxKeax765lDaRdBbxXksm9sU
	V/3oVBnNB+LKp7YUhTb5vkt0m/dc24PiqcJ7FjkOSb856+3YFYTGHkkKgG4/RH4G2CxEQ8
	FA4jOjSBLq3v9fwZtntrR6UbzjjQPR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726568676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuGWZnD6p9BvXmL4N0uz16mbensRF2aEqhxw/6Os88g=;
	b=VXYMTNr+RcGPMnM1ZA81h1IkQtdcFx01Ht1PQkf+xzrDTit8gjjgDgRS86naZpsBk65KSl
	jSUvF/oTQpVVXXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 623D713AB6;
	Tue, 17 Sep 2024 10:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGX0FONY6WafdQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 17 Sep 2024 10:24:35 +0000
Message-ID: <a93c9757-963a-4b4f-a169-0c17ff39576b@suse.de>
Date: Tue, 17 Sep 2024 13:24:30 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 05/11] PCI: brcmstb: Restore CRS in RootCtl after
 prstn_n
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-6-svarbanov@suse.de>
 <9de505c5-d9a2-44b7-8db1-0686c61a0fb4@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <9de505c5-d9a2-44b7-8db1-0686c61a0fb4@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi Florian,

On 9/10/24 19:59, Florian Fainelli wrote:
> On 9/10/24 08:18, Stanimir Varbanov wrote:
>> RootCtl bits might reset by perst_n during probe, re-enable
>> CRS SVE here in pcie_start_link.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> 
> This looks like a bug fix, and we should explain what is the user
> visible effect of that, if any.

It is definitely a bugfix. Otherwise, CRS Software Visibility is
important feature from pcie1.1. Not enabling it on Root Port could lead
to infinite configuration retry cycles when enumerate endpoints which
supports CRS. For more information [1] and [2].

I spent some time debugging it and found that this is not the proper
solution.  I think the issue comes from wrongly implemented .add_bus
pci_ops. Looks like .add_bus op shouldn't call brcm_pcie_start_link()
but invoke before pci_host_probe(), then the issue will fix by itself.

What I observed is that pci_enable_crs() is setting CSR Software
Visibility Enable bit but the controller is ignoring it without error
(reading the Root Control register returns zero). This means that the
controller is not ready to accept configuration write requests at that
time, that's why I tried the following diff which seems to work:

 static struct pci_ops brcm_pcie_ops = {
        .map_bus = brcm_pcie_map_bus,
        .read = pci_generic_config_read,
        .write = pci_generic_config_write,
-       .add_bus = brcm_pcie_add_bus,
-       .remove_bus = brcm_pcie_remove_bus,
 };

 static struct pci_ops brcm7425_pcie_ops = {
@@ -1983,6 +2018,9 @@ static int brcm_pcie_probe(struct platform_device
*pdev)

        platform_set_drvdata(pdev, pcie);

+       //TODO: check for error
+       brcm_pcie_start_link(pcie);
+
        ret = pci_host_probe(bridge);
        if (!ret && !brcm_pcie_link_up(pcie))
                ret = -ENODEV;

Of course this change would work on RPi5 because there are no regulators.

I will drop the patch from the series for now and work on a proper solution.

regards,
~Stan

[1]
https://patchwork.kernel.org/project/linux-pci/patch/53FFA54D.9000907@gmail.com/
[2]
https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4732/original/crs.pdf

