Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D91B8FDA
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDZMfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgDZMfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Apr 2020 08:35:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1145C09B04F;
        Sun, 26 Apr 2020 05:35:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so17123781wmc.5;
        Sun, 26 Apr 2020 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mR3W1kdicgocjFTeQaSq2YWU+mgSB1nOfbQYon3arKM=;
        b=t3drbbnuXXsuO2WREY69j7ZIqs9ECIEuCngubXxD1+BeMteX8F1Z2EMYsfMB6rgl9c
         uk107N230DF0FmqZAflsmsPAkc6CV3GtnR7HnBBP+/rMgFIK5GdUPhZDUjaVMPWNOtxp
         qwlZssVioKt5bDXeyl5IFnRp2dqujF924DJLpYDlCna19+zbgLO1ua9Xa6j/vG8erw1R
         xJGCDmE/E9O5lvzLI2IeeX8THBnDx8xslAvNGCxFOCXn69I6sOCtMGkUgm8OIJa54EVE
         JoJVwrm1vAfdXaaOhVR4ka7zNE9Se85SbgjLva4Bn4U48R1E7G5ND97IjPU3pa3d+vSk
         vrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mR3W1kdicgocjFTeQaSq2YWU+mgSB1nOfbQYon3arKM=;
        b=AEy1R4F4QcO0E331Y28d/bIV2tXWMwQZpk7FfLGc2gWCoQjz8+k3TCSqnQOkYyyFaq
         8rRXdqraHmJwLz1E++9JA0bGbDKOBvvH4kCkSuGdx9LNSC6OKgGZIWiTZ08vOr4BHSlk
         CUt2vAle1LydBdS4xLf9SrOpE+8yIkGf+NaHVJjlS5snbJSi0/dNfFpIyy6S13XnjCyF
         KpbaKUlVD/U3ox9rMHuLx4baU+JOHTbapJVsqfLpF6ID8t3F7At2tFNTFIbMPLVsIjo8
         xbDQy9VwklmCL3zbdIeqJDhYoWVF0az9PP86tnKxiJ6gEzl5og3v5hOX1XD5XWaFDUMQ
         JZRw==
X-Gm-Message-State: AGi0PuZsMvmOCtXVkogHK3flUHvFH/P3zSt1D1D/QV12FlX4rm6+yCM+
        1ew/04wmXJ/6inS8Xa500eXyZtq0
X-Google-Smtp-Source: APiQypLCjWGc7iva97dl05HFoUfySsSw6d/yGeLX4fnR5GVn6SAJQD3ZZjAErxnBpaC8x2tL8cgsCQ==
X-Received: by 2002:a7b:c3ca:: with SMTP id t10mr3527240wmj.94.1587904513272;
        Sun, 26 Apr 2020 05:35:13 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id s8sm16636451wru.38.2020.04.26.05.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 05:35:12 -0700 (PDT)
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20200314191232.3122290-1-marek.vasut@gmail.com>
 <20200320101217.GA22055@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <07fecbce-55f3-af8e-1887-42f7a8074b54@gmail.com>
Date:   Sun, 26 Apr 2020 14:33:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320101217.GA22055@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/20/20 11:12 AM, Lorenzo Pieralisi wrote:
[...]

>> +static int rcar_pcie_resume(struct device *dev)
>> +{
>> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
>> +	int (*hw_init_fn)(struct rcar_pcie *);
>> +	unsigned int data;
>> +	int err;
>> +
>> +	err = rcar_pcie_parse_map_dma_ranges(pcie);
>> +	if (err)
>> +		return 0;
>> +
>> +	/* Failure to get a link might just be that no cards are inserted */
>> +	hw_init_fn = of_device_get_match_data(dev);
> 
> Hi Marek,

Hi,

> happy to apply it as is, I was wondering if it is work taking this
> look-up out of the resume path, it is not supposed to change anyway,
> you can even save the function pointer at probe.
> 
> Again, happy to apply it as-is, just let me know please.

I just sent subsequent patch to address this:
 PCI: pcie-rcar: Cache PHY init function pointer
