Return-Path: <linux-pci+bounces-20078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE222A158A2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BA31887533
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF21A83E4;
	Fri, 17 Jan 2025 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="kzZwHQMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qkOObtjT"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD81531C0;
	Fri, 17 Jan 2025 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737145941; cv=none; b=UBFRTOCeL97tlyFraTekEf2nOBDfDUIEWL+M9GLxlrzKH/XLj2fx3JLXZjCy2T+suqVDeh2u50D7xGe+E43PumdRiBWSWjpHA2BZS5Bnjqir7wmlrfHPopVQPF26xsV3iXS1RQ1H3M4FtJtvrRoucLrt7tKv6cWbzJTAlZeQnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737145941; c=relaxed/simple;
	bh=Wm2xXy07vQCm0yLKUQdE2c9qu1jcksSN8eqllVmlxGQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a6i/7Q6cKdXwD4ECv/JRuuOw5tBvqqtHjVj1Rrj66TnUk1zuIGZ4Bwnz0uDqxSafBUjAZs6+zu2o9DozfAV2NSSa7HDjJuIWkkNVS35559Jhpb30QA9xZ1WuvreVFsfTdypfUGlBRcfJ8cW3UCilKTXy4LzqNSAHo+iDOWu5IwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=kzZwHQMF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qkOObtjT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F09F81380173;
	Fri, 17 Jan 2025 15:32:17 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jan 2025 15:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737145937;
	 x=1737232337; bh=bXmFpberHDuxWhiPnVlYNRFaHaFpNzdFO/TG9li4q5A=; b=
	kzZwHQMFHjC/82usFB+HhkJidn+vAqFPEFjDNN/6kapNfnkCnBhpIfhrvSkMQa3q
	5tYmNuV9crkpX8SJGQ4al1WRV/5oK96lXEGd5s6HdRMCT2IywiRMNkUihORvktOj
	/HMhyJQOwiD+nYnIZp7kJwPb6CHT0MNpHb/wWx8d1v81SeJrm7jRJdTHLCEMdRY7
	PUGYY9MEbUdrbt+fa2K55ogdkqKyYWzgk67cJY48W2FpnFVGQiV86RC0rGkONY7S
	99XqUYJ40zTexodeeHe7vzCAEQ0HJfuhjh1fFzJNhotxTzZhKoFtd0ZHPzlQ4gK+
	pf1ivoiv6mBa4o/QZdufxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737145937; x=
	1737232337; bh=bXmFpberHDuxWhiPnVlYNRFaHaFpNzdFO/TG9li4q5A=; b=q
	kOObtjTOL2KLC3Lq6Zx+7y9WDc0uzjcifbJxsHR9bNm3gO3GSwIUVLGOz+62bsjh
	h7b8iepv8eNsq9smaU/ZQ5RQAykltSQKsb7rlfaKnRmtz7DD9fW4NrbBGZT3bTKv
	ayzMf/GlYHlSkoFOrEH+aw3iXjr3+RRIZyfyAlsR/l8coqH3/lcB9sp6trPBXZuE
	QQK8FbMYHJK0/lmYQaiZR1LV8xJ/3sc1j00CZ45fdHsouByij0YfakDWgdxavv6d
	m99GI1ri/6QAT1JUElEtFp1vK1VKGOawHfAaVr9kn95+/ZiYGjoq80DmPwO1Ub2d
	z7UnsSI7YdQbkLFr/gPrw==
X-ME-Sender: <xms:Ub6KZ8LvEjKA8_8Wh-0bIP85kd_gKvCC71_zaghQLCDIKpj7_7k6Yg>
    <xme:Ub6KZ8J9RuAF8GIHj00kjeoSbq0uv5orqtvMWd7__Fs7MPxSR9f0CkiUBv7u41SC7
    hcMtCZB865bSclM2fI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnheptdffvefgtefhveet
    uddvfeelveektdduvdelgfehgfeikeffjeetjeevffektdfhnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprh
    gtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrihhordhl
    ihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheprggtvghlrghnrdhkrg
    hosegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuh
    igrdhinhhtvghlrdgtohhmpdhrtghpthhtohepkhgrihhhvghnghhfsehnvhhiughirgdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Ub6KZ8svOPU6APQtslmj3_bFWHJNdBQ1tw28zJ4xYYUR7GIRMEZ-vg>
    <xmx:Ub6KZ5Yn5EHaPNFzeMzwiKD-1DMZ267eKuzYv5PcX6XvPunc1lK8Uw>
    <xmx:Ub6KZzZjQdglByvaw785ASco636wtrDLrgkWPMZ6wrv-5gqr7ScfHQ>
    <xmx:Ub6KZ1BeqJ1VeLoPxIuVd7TOMIL-x4hcL5sDHSf48rVC54n_W2a7hA>
    <xmx:Ub6KZ4PJA-yrlUAbnkPcBttsAXIcnB8_AeeuwWrMWWcQPcEvgrIp_gZ_>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BA713C0066; Fri, 17 Jan 2025 15:32:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 15:31:57 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Kai-Heng Feng" <kaihengf@nvidia.com>, bhelgaas@google.com,
 mika.westerberg@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "AceLan Kao" <acelan.kao@canonical.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>
Message-Id: <69ddda46-62cc-445f-a1ef-f4651ec0b138@app.fastmail.com>
In-Reply-To: <20241208074147.22945-1-kaihengf@nvidia.com>
References: <20241208074147.22945-1-kaihengf@nvidia.com>
Subject: Re: [PATCH v2] PCI/PM: Put devices to low power state on shutdown
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Sun, Dec 8, 2024, at 2:41 AM, Kai-Heng Feng wrote:
> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> connected.
>
> The following error message can be found during shutdown:
> pcieport 0000:00:1d.0: AER: Correctable error message received from 
> 0000:09:04.0
> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data 
> Link Layer, (Receiver ID)
> pcieport 0000:09:04.0:   device [8086:0b26] error 
> status/mask=00000080/00002000
> pcieport 0000:09:04.0:    [ 7] BadDLLP
>
> Calling aer_remove() during shutdown can quiesce the error message,
> however the spurious wakeup still happens.
>
> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown to solve the issue.
>
> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> compatible with the current Power Resource states. In other words, all
> devices are in the D3 state when the system state is S4."
>
> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> state is similar to the S4 state except that OSPM does not save any
> context." so it's safe to assume devices should be at D3 for S5.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
>  drivers/pci/pci-driver.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 35270172c833..248e0c9fd161 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>  	if (drv && drv->shutdown)
>  		drv->shutdown(pci_dev);
> 
> +	/*
> +	 * If driver already changed device's power state, it can mean the
> +	 * wakeup setting is in place, or a workaround is used. Hence keep it
> +	 * as is.
> +	 */
> +	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
> +		pci_prepare_to_sleep(pci_dev);
> +
>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>  	 * device to tell it to not continue to do DMA. Don't touch
> -- 
> 2.47.0

Just a note that we've tested this in the Lenovo Linux team and confirmed that it reduces the power draw on a powered off Z16 G2 by 0.6W.
This is enough to bring Linux inline with Windows, and more importantly allow the platform to pass e-star energy certification (which it otherwise fails). We suspect other platforms will show similar benefits.

Let me know if there's anything we can do to help get this patch moving along - I think it's important.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

