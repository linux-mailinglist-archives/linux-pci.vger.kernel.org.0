Return-Path: <linux-pci+bounces-36768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCCB95E50
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5A93BFE42
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F8322DCC;
	Tue, 23 Sep 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cqWc4AFf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AB3164A0
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632139; cv=none; b=iaoCQ8fJjVNjtXRCh51oHaYF14myQGFMQinZyMyCrUmpEZ50+R5NdnsMkmSyZmoNQ4xQ93qyaSp+t3+fwq7/Nh3Wgi4qj6H+RIEcg7bUL7pYFCFiovLE7h9o7QTzC20lY1TjlMWxIbquJmIdqjQkGtd+L901pO3qynLp5NXJ4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632139; c=relaxed/simple;
	bh=eLS+3L+WH/3oUK1KdScdYxGZmccSVzRYZZWCamfUCQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SD53ZmEJ1Ml9AnTA+Yytv30r0/5php+eOh+zLnvse1CRvlP1/Pymbtjc1UwFtyOYmGo32Z65TXKec+Xe0ofVROSGF9WSxHS0EjetmtYYDFiLN5S5n/RfX7CaSyfgPZNFbTvJk7DXKdFgxvZzWN1PMEBF01vFS0LzRdieSxzKlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cqWc4AFf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2914139f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758632136; x=1759236936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaIg4jDl9jFZTYzzE1kP2lbNTLyhNR0UhkVfuAOFPbU=;
        b=cqWc4AFfAM96UtCVjz/5MIqSxFEpPwa+74UA3pacyceoShYe+nPmCjrueOs5X0idj9
         QQEkIR2ZLsFpbqHA4WKPfAH/jyks3sNE4h6MlCnyGtpZE483XMy+nPYx3HQb11vjAmHX
         yIJAZEp7V6PPxkPnC0fsMhlNGX8TJ/4q97r5AUEoY7wEBQLZMgjbCMbauzInMaWflFOx
         iUO7aisFvjVCpxvgqKND8a0nJh05mzOTqR1t58tnmgsTV2QuotTYxa/PDbBi3rSxkdRz
         K+cX3GmR2q3RSba0Jrq1vX1nAj1Km4dEEbA/5rjg5MLgr8cEv2GzieHQzp7xKIxxoYl0
         j6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632136; x=1759236936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaIg4jDl9jFZTYzzE1kP2lbNTLyhNR0UhkVfuAOFPbU=;
        b=MCyq/Xfg/poj8jo/L/yw69D2oZLPW3e+boCIL03dv1wwymTBAp5RrPPJIblabvAigU
         lGZUmIMZbXfaTb2VLOl+llA7M/BiIRvdmxzTmHjZpBIzcpjjaRlvsSUd7QCJT+Qj9O4A
         l08vQPz8fhqbEfj+YkA6zpwKmPsQxcsw5Lil0gFy/gaRCBZsQv+tilgEQ/3ymEbbyshy
         VKp/nHQrC6r4WNlnjGXGyetSOV46Pf6TBu0yRyvUiJFR6hgajxzTkNxdVGWpd5YSEr9a
         VT3LIycmJ/gMxijbIbcrxoG3b8pSsKzuo3ToSOamRL6fgPoXBtiWmW0fXU48m70tlml4
         NkSA==
X-Forwarded-Encrypted: i=1; AJvYcCXUAQgnbf8qh0gDHjxfpwVYQhbW7pf36hMsNrTTIDa3/5flYdPmvsCJCcd55LnQxu+hmSQ2l2I+DCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4RmtcAIckWQ5ox3mpfjeRmUZuU9Cize8hh5uB3hAokt+mbid
	S6zXOdbwk5FlOEMMENU7iF+R1FSaKFR+Q9N4LmxcDE8JlFxAGnefoFNilRpUy/CWppY=
X-Gm-Gg: ASbGncvWlicP3cNcjJQgSQtC9p4sIzRMeL8Ce98HntRjo4XfweyMvjGZYsBfNBnVRpQ
	B7We1hEs4GRKDG671j/mbsomvZpLehyXA1Rc78/iga1aOKpQympZZb0VvzKxUbPgpltvVLeqXk4
	WGW5giwLRTapN8Rt3H0RuSmSqudkzO619k5wL+CVHcRJXwl+/gqteoZGQUTv3TRDxBZcoZO92ia
	uxEYPs59eeRhoAoznaUN9vcPN1PeI7/CXp7DDJOxyrFRdjxpWgtvSCBsRYD2vjOS0ZUhz+rlYt4
	PSnAtBVguf8stjAeAZTnu5F40Dg3sd/tJXv6gq9XeigHDvJfw2iiaftebyvTchntqfkjSEb5hwZ
	3ayiO1FQM5akCHvlVK0gJkLjjx98nrze69Kth2P7z0AA=
X-Google-Smtp-Source: AGHT+IG0uyoZNs0i41rqkNkMaZFqouCej55fWirbDUl/J5m3XVuK1w9+Aykmm/3MDPy3vac3H7+Wyg==
X-Received: by 2002:a05:6000:4025:b0:3e4:957d:d00 with SMTP id ffacd0b85a97d-405cb9a5225mr1756055f8f.58.1758632135758;
        Tue, 23 Sep 2025 05:55:35 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a286edsm273702715e9.16.2025.09.23.05.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:55:35 -0700 (PDT)
Message-ID: <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
Date: Tue, 23 Sep 2025 14:55:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>,
 Sami Tolvanen <samitolvanen@google.com>, Richard Weinberger
 <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250912230208.967129-2-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/25 12:59 AM, Brian Norris wrote:
> The PCI framework supports "quirks" for PCI devices via several
> DECLARE_PCI_FIXUP_*() macros. These macros allow arch or driver code to
> match device IDs to provide customizations or workarounds for broken
> devices.
> 
> This mechanism is generally used in code that can only be built into the
> kernel, but there are a few occasions where this mechanism is used in
> drivers that can be modules. For example, see commit 574f29036fce ("PCI:
> iproc: Apply quirk_paxc_bridge() for module as well as built-in").
> 
> The PCI fixup mechanism only works for built-in code, however, because
> pci_fixup_device() only scans the ".pci_fixup_*" linker sections found
> in the main kernel; it never touches modules.
> 
> Extend the fixup approach to modules.
> 
> I don't attempt to be clever here; the algorithm here scales with the
> number of modules in the system.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/pci/quirks.c   | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/module.h | 18 ++++++++++++
>  kernel/module/main.c   | 26 ++++++++++++++++++
>  3 files changed, 106 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d97335a40193..db5e0ac82ed7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -207,6 +207,62 @@ extern struct pci_fixup __end_pci_fixups_suspend_late[];
>  
>  static bool pci_apply_fixup_final_quirks;
>  
> +struct pci_fixup_arg {
> +	struct pci_dev *dev;
> +	enum pci_fixup_pass pass;
> +};
> +
> +static int pci_module_fixup(struct module *mod, void *parm)
> +{
> +	struct pci_fixup_arg *arg = parm;
> +	void *start;
> +	unsigned int size;
> +
> +	switch (arg->pass) {
> +	case pci_fixup_early:
> +		start = mod->pci_fixup_early;
> +		size = mod->pci_fixup_early_size;
> +		break;
> +	case pci_fixup_header:
> +		start = mod->pci_fixup_header;
> +		size = mod->pci_fixup_header_size;
> +		break;
> +	case pci_fixup_final:
> +		start = mod->pci_fixup_final;
> +		size = mod->pci_fixup_final_size;
> +		break;
> +	case pci_fixup_enable:
> +		start = mod->pci_fixup_enable;
> +		size = mod->pci_fixup_enable_size;
> +		break;
> +	case pci_fixup_resume:
> +		start = mod->pci_fixup_resume;
> +		size = mod->pci_fixup_resume_size;
> +		break;
> +	case pci_fixup_suspend:
> +		start = mod->pci_fixup_suspend;
> +		size = mod->pci_fixup_suspend_size;
> +		break;
> +	case pci_fixup_resume_early:
> +		start = mod->pci_fixup_resume_early;
> +		size = mod->pci_fixup_resume_early_size;
> +		break;
> +	case pci_fixup_suspend_late:
> +		start = mod->pci_fixup_suspend_late;
> +		size = mod->pci_fixup_suspend_late_size;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (!size)
> +		return 0;
> +
> +	pci_do_fixups(arg->dev, start, start + size);
> +
> +	return 0;
> +}
> +
>  void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>  {
>  	struct pci_fixup *start, *end;
> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>  		return;
>  	}
>  	pci_do_fixups(dev, start, end);
> +
> +	struct pci_fixup_arg arg = {
> +		.dev = dev,
> +		.pass = pass,
> +	};
> +	module_for_each_mod(pci_module_fixup, &arg);

The function module_for_each_mod() walks not only modules that are LIVE,
but also those in the COMING and GOING states. This means that this code
can potentially execute a PCI fixup from a module before its init
function is invoked, and similarly, a fixup can be executed after the
exit function has already run. Is this intentional?

>  }
>  EXPORT_SYMBOL(pci_fixup_device);
>  
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 3319a5269d28..7faa8987b9eb 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -539,6 +539,24 @@ struct module {
>  	int num_kunit_suites;
>  	struct kunit_suite **kunit_suites;
>  #endif
> +#ifdef CONFIG_PCI_QUIRKS
> +	void *pci_fixup_early;
> +	unsigned int pci_fixup_early_size;
> +	void *pci_fixup_header;
> +	unsigned int pci_fixup_header_size;
> +	void *pci_fixup_final;
> +	unsigned int pci_fixup_final_size;
> +	void *pci_fixup_enable;
> +	unsigned int pci_fixup_enable_size;
> +	void *pci_fixup_resume;
> +	unsigned int pci_fixup_resume_size;
> +	void *pci_fixup_suspend;
> +	unsigned int pci_fixup_suspend_size;
> +	void *pci_fixup_resume_early;
> +	unsigned int pci_fixup_resume_early_size;
> +	void *pci_fixup_suspend_late;
> +	unsigned int pci_fixup_suspend_late_size;
> +#endif
>  
>  
>  #ifdef CONFIG_LIVEPATCH
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b26184936..50a80c875adc 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  					      sizeof(*mod->kunit_init_suites),
>  					      &mod->num_kunit_init_suites);
>  #endif
> +#ifdef CONFIG_PCI_QUIRKS
> +	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
> +					    sizeof(*mod->pci_fixup_early),
> +					    &mod->pci_fixup_early_size);
> +	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
> +					     sizeof(*mod->pci_fixup_header),
> +					     &mod->pci_fixup_header_size);
> +	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
> +					    sizeof(*mod->pci_fixup_final),
> +					    &mod->pci_fixup_final_size);
> +	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
> +					     sizeof(*mod->pci_fixup_enable),
> +					     &mod->pci_fixup_enable_size);
> +	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
> +					     sizeof(*mod->pci_fixup_resume),
> +					     &mod->pci_fixup_resume_size);
> +	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
> +					      sizeof(*mod->pci_fixup_suspend),
> +					      &mod->pci_fixup_suspend_size);
> +	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
> +						   sizeof(*mod->pci_fixup_resume_early),
> +						   &mod->pci_fixup_resume_early_size);
> +	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
> +						   sizeof(*mod->pci_fixup_suspend_late),
> +						   &mod->pci_fixup_suspend_late_size);
> +#endif
>  
>  	mod->extable = section_objs(info, "__ex_table",
>  				    sizeof(*mod->extable), &mod->num_exentries);

Nit: I suggest writing the object_size argument passed to section_objs()
here directly as "1" instead of using sizeof(*mod->pci_fixup_...) =
sizeof(void). This makes the style consistent with the other code in
find_module_sections().

-- 
Thanks,
Petr

