Return-Path: <linux-pci+bounces-2924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B2845A7E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AD9B20F5E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B95F480;
	Thu,  1 Feb 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEH1QWEi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126C5F469
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798725; cv=none; b=FPFjLou8deMcp5JbkCNz1DR6RwD+DnN1E3Fa/w5xPHrnHBlgpVu5c7m715hsGJnbdlqP35vAr7St3yKUH7zQsk6yTPjRr5wneU1VW1HNPovFE2OPLEYGjb3f9PJAgaMI7XosnZsilm2K5tOqyw5s6LX9aWlgHbiNywiO8jZhptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798725; c=relaxed/simple;
	bh=g28Uh0jEGcZw1jbRzd3E+2nC216DW2FMQTibILMYzNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIk5ZjrXBYnJWqVFN7y48bfjpgTTjftawU66fEqr1C3TIUh7YNjEfyzvYmItV1n76aNXscOW7FPpUSNpQGgSbJW5Jc0PN3PE2EvuedziTKI7UOIfTBfseYMnJmDg/yEzC91VuYzx7sHNUxKalPVqUzvmQurosshlm1q4T2iWEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UEH1QWEi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so719398a12.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 06:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706798721; x=1707403521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=emBBEOIhMF1O2hGGxGh+HkrTeoWxjLOYDw2I2/VoJkU=;
        b=UEH1QWEiOaTyvl9ngqYMoCBIYNijdWlGw7STHgUI6kVOHP7BKiGPcBUVkoinhRoKeZ
         lZKVzysnFje27nCQ46l7Tn6/mxzqub3pRYXtjFVPnjo759OgoMC6LY/tm2A3bYhjXRCB
         /mUrq0eKS534zZBM80RmojkuLgZBRQ4AR7m7dNbO79u0NFWR+dmouYABxvuRy1Y2gdR+
         ZEG3OlzJ6HyMzC4flVIPmQ933kxvtyCDoh8D/IpYFOrmCUamEBQniW9V9ML0VCJcqRpQ
         li0qOG9DI4ZgluVXI9UyKZbAyjlcf84xxA7hQ9DqoETDu2zDbfhbuJr2VJJA75464HB2
         mVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798721; x=1707403521;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emBBEOIhMF1O2hGGxGh+HkrTeoWxjLOYDw2I2/VoJkU=;
        b=gUjyo7GOQ6qE+TKh06nR0Tcx7EeFGfvEygXQGhz0xNZk6UBWQox5F77McLdoqwibWj
         p1vOcdQH3z2EebcQrQVC3HqTthTmPDFCbPIj6CXf76yEmbFmvQ4iB91GE5vKj/2/PHBO
         TAsCeNRnJqU0ttm9YXLgCaqhmTZIgxKYHKR+1x5QRADHDEh+M4dbO+R/6hSDSCD7h+mH
         hvd22FoZypeC2nhM7OrmB7Qu/LMESGVUxgYQCkESSun5bNq6rfi8ZKGbRK8BkaDtEWt/
         ZbiWjWx7nzoE6n+xiCyvEdbU4LTYWONHC2Jr+lT1+UtZHoqyAjGBFVFBapU5sFEPMx0r
         2ubA==
X-Gm-Message-State: AOJu0YwLXZZF5Ng19NF+WrVTnnRs/2CbP/+bBkbrR2OqXwaAG4xE4D9k
	ooAfbRurv8GtW5xBmT3F+h1WooAekJemJxec6WvCxn1mZvmV23bPIqS+DirZrsk=
X-Google-Smtp-Source: AGHT+IFeiHTp3Fuz7wGLQZ4zS4Zvyu5bQGeQK1nbyADucc/rYuDqxeNfv/vTAVPG4XaqEunLGNirUA==
X-Received: by 2002:a17:906:8315:b0:a2e:93d6:3680 with SMTP id j21-20020a170906831500b00a2e93d63680mr1934018ejx.43.1706798721404;
        Thu, 01 Feb 2024 06:45:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXeJzG0tsIH89YgeMZULH19Hzp5v5mM27kxBeCtFb4kukzeRP13p874DcpHhU+xT9boslD2j1H/T05C0OTf2OTHaMTqVAoEZHoY3wL583AQrXHPAVYXec/JSo5TPDfEmKpYz3T1p8uTNlXGiwV96g33tMDvyARHkjZL6x5PCkuhEOBL2v0suO5I9P8cvdjzaYGSeNK50eE1Z1HujCbGChDbjSzQm8/kT7KWi5SPzuKRLUeti4F5PzUtGZ4O2yLnhPCLqD4MMHQ1GQk+IPjJuuAkEMXoUcXoVYkbdx7ZUt1gNKOfZw4oichrbTsmcJIa+6sPHRvwsh/DVLH9IrhrnwRPzv7oQWoricpCli5lb3Fx73vdteC+kxTEYGr/rZ8mtQJgAzGv7gIAllu39yGoHGng20i1YL67mcRxn4KtogMb3MDk1Cq/xvLJbqvpRMUBxZvBWSzMn9AU9KUTWLjvgM2TuL8KXIvgzwkIzCl2zEsGSMELLRESpDm2LMgNmg88QaKtonMc5B1sfNztf3LK8WBxJWYMt7LEzejBlhApQtkW2aeORkOZM/FhAM6DFe3fng13c3L94HjZhXjr8O5pvC1OVUL/WKZrNGM8KmvlAtPWXLih4IPY2PZpq0XKZeG/ZzwPc238nPyv/abTQNGoHHvFrmj+lob2A7gm7gfqxmAhk9WJIr1+
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id ci11-20020a170906c34b00b00a2f181266f6sm7372628ejb.148.2024.02.01.06.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:45:20 -0800 (PST)
Message-ID: <610d5d7c-ec8d-42f1-81a2-1376b8a1a43f@linaro.org>
Date: Thu, 1 Feb 2024 15:45:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Johan Hovold <johan+linaro@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
 vireshk@kernel.org, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7> <20240130131625.GA2554@thinkpad>
 <20240131052335.6nqpmccgr64voque@vireshk-i7>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240131052335.6nqpmccgr64voque@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.01.2024 06:23, Viresh Kumar wrote:
> On 30-01-24, 18:46, Manivannan Sadhasivam wrote:
>> Agree. But what I'm saying is, right now there is no DT property in the
>> interconnect consumer nodes to specificy the bw requirements. This is all
>> hardcoded in the respective ICC consumer drivers.
> 
> I thought there are a lot of users already in there..
> 
> $ git grep -i opp.*bps arch/arm64/boot/dts/ | wc -l
> 864
> 
>> But when we use OPP to control bw, the bw requirements come from DT. This is
>> what I see as a difference. Because, only nodes making use of OPP will specify
>> bw in DT and other nodes making use of just ICC will not.
>>
>> Maybe I'm worrying too much about these details... But it looks like
>> inconsistency to me.
> 
> Right. So is there inconsistency right now ? Yes, there is.
> 
> The important question we need to answer is where do we want to see
> all these drivers (specially new ones) in the future. What's the right
> thing to do eventually ? Hardcode stuff ? Or Move it to DT ?
> 
> The answer is DT for me, so the code can be generic enough to be
> reused. This is just one step in the right direction I guess.
> Eventually the drivers must get simplified, which they are I guess.

I'm lukewarm on this.

A *lot* of hardware has more complex requirements than "x MBps at y MHz",
especially when performance counters come into the picture for dynamic
bw management.

OPP tables can't really handle this properly.

Konrad

