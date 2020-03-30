Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4056197FC1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 17:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgC3Ph1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 11:37:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36747 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgC3Ph1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 11:37:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id u15so5472451lfi.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2020 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7n3YZ9nrtrOOLXOcT8nncmyYyXz4uqz98on2S5Nc7P8=;
        b=01eIbogv2JLufuwCILlbzumO6l4tm31Ysgk7fk42vDAxQ8S2Jzsv8Wmv4QoNc7JGoW
         ouw5WNKmvQfSWsT0guoBS+abSnxPIUBaZq+93d3O8EtcYlHlgllZAJbG54iZ/nD5jBFn
         OIoiFNWZu5IjFAx5DgOVhaacynAAMj+OfbkrpP/mTBee7Fz1zQVz2hquYPqLxN6BYiFw
         kD5CEjp7KqELCqjwfe87awk3DYkzx8qV8BaYb3Z9bNrKGkVdDWSacv6Rj7ZVgaRQGRSP
         7DwLX8kVEeiHuYvpEBIeBYkQPyLojrINApEH61LvdBgEHDiZhRApfDDwkvEg7ohY3dws
         thEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7n3YZ9nrtrOOLXOcT8nncmyYyXz4uqz98on2S5Nc7P8=;
        b=Zn/6FyxU9ptROijj0XbInvfZzRzNdy75TIHSmhdHlFe362Z4M74uUmWSBBUb+AHUgr
         OCJYtJxcYS9p+e/T0Wie19N3UmD9DgjFbUiKiI0Wq4Y8QNo+eIiGwQ+N9HKc+k48PmUI
         zKDMxBWWHF/NkLERWEcn3tHATNWl6roW7tDdZvyDi03r5cTCK8c0i3k0dH+BL645wdCO
         OstiGlQENHrJNohSLCnGH4Vx4AoqbY4Ga84AuLMK8m5cE5T7bzm6109/0en+T7l239A3
         4vwmDwElMuL3qPPyBdWxnZ+fMknihp0EMt0rM5Z8IXKBg6RUKDRqWuKLp9/OApSzLOmZ
         Ckfg==
X-Gm-Message-State: AGi0Pua/CDx/mDmC0Kk21Y8imz374opshkDE2/RxQFl8iwa8s+mb9KR6
        qIVp37HBRiQE/Te1eJqhoqsP/g==
X-Google-Smtp-Source: APiQypLCq5vVr1YrIW3e4xrFpb9STHZkBueQeFK1AR43Hf0SWSWV1m1Evg2KTFYl5nebk26zdn6zwQ==
X-Received: by 2002:ac2:48b3:: with SMTP id u19mr8289783lfg.84.1585582645078;
        Mon, 30 Mar 2020 08:37:25 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:654:d00e:d4e2:9dcc:b9fb:a661])
        by smtp.gmail.com with ESMTPSA id i2sm7910219lfg.23.2020.03.30.08.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 08:37:23 -0700 (PDT)
Subject: Re: [PATCH 4/5] MIPS: DTS: Loongson64: Add PCI Controller Node
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200330114239.1112759-5-jiaxun.yang@flygoat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <68446094-263d-d0d9-df00-bc1e81c1dffe@cogentembedded.com>
Date:   Mon, 30 Mar 2020 18:37:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200330114239.1112759-5-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 03/30/2020 02:42 PM, Jiaxun Yang wrote:

> Add PCI Host controller node for Loongson64 with RS780E PCH dts.
> Note that PCI interrupts are probed via legacy way, as different
> machine have different interrupt arrangement, we can't cover all
> of them in dt.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
> index 45c54d555fa4..f09599a4b9d7 100644
> --- a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
> +++ b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
> @@ -5,10 +5,25 @@ bus@10000000 {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> -		ranges = <0 0x10000000 0 0x10000000 0 0x10000000
> +		ranges = <0 0x00000000 0 0x00000000 0 0x00010000 /* ioports */
> +				0 0x10000000 0 0x10000000 0 0x10000000
>  				0 0x40000000 0 0x40000000 0 0x40000000
>  				0xfd 0xfe000000 0xfd 0xfe000000  0 0x2000000 /* PCI Config Space */>;
>  
> +		pci@1a000000 {
> +			compatible = "loongson,rs780e-pci";
> +			device_type = "pci";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <0x1>;

   No need for 0x.

> +
> +			reg = <0 0x1a000000 0 0x02000000>;
> +
> +			ranges = <0x01000000 0x0 0x00004000 0x0 0x00004000  0x0 0x00004000>,
> +				<0x02000000 0x0 0x40000000 0x0 0x40000000  0x0 0x40000000>;

   No need for 0x before 0 here either. And why double spaces?

> +
> +		};
> +
>  		isa {
>  			compatible = "isa";
>  			#address-cells = <2>;
> 

MBR, Sergei
