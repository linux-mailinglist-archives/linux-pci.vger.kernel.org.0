Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E77902FC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfHPN2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 09:28:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54833 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfHPN2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 09:28:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so4049517wme.4;
        Fri, 16 Aug 2019 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yFsIYv4bGAmaVrs0URU9ok9a5QdRbAR/pzGWGa538b8=;
        b=QnNE9Ob2h6ChmxFj93mut2j+3VGyfReLDYOS20KFAJLp4T7BgCZeQGEhCkFZCbrDlC
         sYVcOEOq2UlvqUGViknvvsMT+ovHmOKBOo4MWENkBYHW5oRtS0rJjkwSKIlwWuG96IBD
         NaE1l3RnOB4R/onmxYM7w6QHzqLKGIIuG9CKTNgMDQ64wWNOVShiu+yF3O6MSPcc84xO
         7io8GuoMU38ugzoabcORI2kEnDzNXBlaj8K3GcxtCJx3lWtaUUER58AF0YQbMS/Qc/+6
         biv+35AS7JNfx0jvcde31N/sqULM+2vR2aiN5RjPoDY0jPyIOlsM/cZ0rr1OFLq4GfZX
         pLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFsIYv4bGAmaVrs0URU9ok9a5QdRbAR/pzGWGa538b8=;
        b=pQD800X55+3oZGPcttPqOXleQqxgXem7muuYet0rsNIOHS0OKoQqcWmgmSWuPA8uAM
         OHVF2s6AuyPvyGVETj4FlVrF4dg2MR83DD3rmyCl0qjHxFrw1XqporfAXj3PGMPkvcsJ
         J7+5S6F1cuqDLUTG+UYwpgJ3AXGMVCMFo2nCUhuS8chk3bh1iiqUU64KxEuhyOiIy1Uj
         SOq5uUhPbjb8JPdoKENBWsSrMxTv4zxeLqUlgyK1Ol+KYpwAVN1xkq8o1PdlEQ84Ole9
         cWCZwkrUwHOVoKNGqqs2EW5KPmuVAX5Y8JTkayoOIcAwO8cYNUUlsbz2A9uSXwwrVy25
         srJA==
X-Gm-Message-State: APjAAAUUEAdDWu0SlGOO5pO+culCNpogq7ZN477KCc6AB36kvVcxIDGq
        oBIW2S2hxZ53CoUTOt6sVmGLMp31sz4=
X-Google-Smtp-Source: APXvYqwAoO8xjPsNMeSCS4bJTO7163fxGUWV2QLDFNKVBr26sP+hDyfaE6ZVNxAu10Lakh/66i8jxA==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr7819003wmj.39.1565962086752;
        Fri, 16 Aug 2019 06:28:06 -0700 (PDT)
Received: from [192.168.42.64] (p578adb1c.dip0.t-ipconnect.de. [87.138.219.28])
        by smtp.gmail.com with ESMTPSA id g197sm2096887wme.30.2019.08.16.06.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 06:28:06 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Simon Horman <horms@verge.net.au>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
Date:   Fri, 16 Aug 2019 15:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816132305.gyyml5r3xsimmoor@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/16/19 3:23 PM, Simon Horman wrote:
> On Fri, Aug 09, 2019 at 07:57:40PM +0200, marek.vasut@gmail.com wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> In case the "dma-ranges" DT property contains either too many ranges
>> or the range start address is unaligned in such a way that populating
>> the range into the controller requires multiple entries, a situation
>> may occur where all ranges cannot be loaded into the controller.
>>
>> Currently, the driver refuses to probe in such a situation. Relax this
>> behavior, load as many ranges as possible and warn if some ranges do
>> not fit anymore.
> 
> What is the motivation for relaxing this?

U-Boot can fill the ranges in properly now, the list would be longer in
such a case and the driver would fail to probe (because the list is
longer than what the hardware can support).

-- 
Best regards,
Marek Vasut
