Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6939F058
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhFHIEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 04:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHIEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 04:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623139359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKpNGaQCUEHHfd7MT/ExHFw1fhpDia+6aX46sXXLlDs=;
        b=Kvn4TFMZOAUyxVrwnXauBqtNYxbRItiHH/yuEiWAqJftxLHU3tbtTtiA+jb2EMjRejb2Pz
        7Kn4DlCXNoKmSe28MyejrxqSD0j++FUs0M1f3+JZtUhp3kps4jDi+OPfyW+a0OHOwDkECa
        LJTH/+Hfl7IR9noQP+bHdiNF8DXLXqY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-QOxy7wxuMSiXVrAWpziEPg-1; Tue, 08 Jun 2021 04:02:37 -0400
X-MC-Unique: QOxy7wxuMSiXVrAWpziEPg-1
Received: by mail-wr1-f69.google.com with SMTP id z13-20020adfec8d0000b0290114cc6b21c4so9013087wrn.22
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 01:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nKpNGaQCUEHHfd7MT/ExHFw1fhpDia+6aX46sXXLlDs=;
        b=RJ6MNz4nbzyvtgoRZfL1MhcixylNaelBjmaRp5BIRePS1v72CevzM9/p8SeP9JHdbc
         TYqKY7GY9AJvdLcRYE+LA2d6a5hxZjzl3FJ0jARQSEj5lEp1H59Rt/2mvbaCuAF+crvH
         dt/04G1lDSMKxh1W3zv6PCfmBqR0iMoc3d5Kapf3naegPueJg4X4XXqtrIEW/3gZpMYb
         qhIKerN8GelF6gckJWxvnESfwXT6P0eb9TkljYZo282W0xShF1CQyA0PVLQc2uRbSQ/H
         7MsCfM3LhLxRZfjGWjnrLxYNgyNExiHjxM4jUQMgAHikIa18ADyNAU1vXie0vZKxNT2h
         u9cg==
X-Gm-Message-State: AOAM531VjDazST4dw98jZwYNbJnCNsfjmT238mDDwmVmkL39bBSuSLki
        qMjwl/VNFD/dCBSpeuPaZQLgB2OyESfqSZ8IeuHSTwFo2lianxEaxvJp5WU7Q3s9GC/sgL6c8Rw
        CCu9lZ0A2VqfiGTZk9oap
X-Received: by 2002:adf:ded0:: with SMTP id i16mr21414769wrn.30.1623139356112;
        Tue, 08 Jun 2021 01:02:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYrfpKlnATy0WFWItLlG9XWgy/bAHikZyJwX4kOJpLKQCbfPOgnNUWOVssDtv6XqK4j3LEnQ==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr21414737wrn.30.1623139355894;
        Tue, 08 Jun 2021 01:02:35 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id h9sm2039560wmm.33.2021.06.08.01.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 01:02:35 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_PCI=3a_rockchip=3a_Avoid_accessing_PCIe?=
 =?UTF-8?B?IHJlZ2lzdGVycyB3aXRoIGNsb2NrcyBnYXRlZOOAkOivt+azqOaEj++8jOmCrg==?=
 =?UTF-8?Q?=e4=bb=b6=e7=94=b1linux-rockchip-bounces+shawn=2elin=3drock-chips?=
 =?UTF-8?B?LmNvbUBsaXN0cy5pbmZyYWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210607213328.1711570-1-javierm@redhat.com>
 <c3f49fe5-edbe-2889-bd59-92891adc807b@rock-chips.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <805741e9-b814-32a5-38ce-bc13df6efb0c@redhat.com>
Date:   Tue, 8 Jun 2021 10:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c3f49fe5-edbe-2889-bd59-92891adc807b@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/8/21 8:48 AM, Shawn Lin wrote:
> On 2021/6/8 5:33, Javier Martinez Canillas wrote:

[snip]

>>
>> So let's just move all the IRQ init before the pci_host_probe() call, that
>> will prevent issues like this and seems to be the correct thing to do too.
>>
> 
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
>

Thanks a lot for the ack!

Peter Robinson noticed a missing word in the changelog, I'll send a v2 now.
 Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

