Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2078C69576B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 04:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjBND1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 22:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBND1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 22:27:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43315569
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 19:27:08 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id bt14so2474716pfb.13
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 19:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16MWv8psoN4+i0L8PGIdQnwvghfOx1eJ9GIi//wCpYA=;
        b=OAGf8NYt7iZzPfOLyC3DmCzUXmRCcc8UJSRQtmC25T+cGSs7zaveppl63MjlICHoVX
         hx0FhT2An45tyXSnQdRaRbGnv49TmF4efnhlALuR/nnY+j/Dk6cQ7r1SwGoW39bBe2CC
         /4qjjrdBLwWwRHiaymi0RlmgedtxChRL9Ycnv8bks+op1RafGiGARJr8tzjdS8U9ypoC
         tptEIqc1JwX8vBJJZxTkXTjmGBrQDvN2BcSszFyLWY9qe23WaBb06tLr9301QJhQI3Uv
         bzd0yShKOCSktafnqA4EliUIj+uTSUzwKTH8TOd/N9ft8is8wtQpD2vISgVnSH4ShqXk
         91vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16MWv8psoN4+i0L8PGIdQnwvghfOx1eJ9GIi//wCpYA=;
        b=xLMt+5yM9PV2le73+2128TlZleZTNre+eSkCK+pwNcmm1bXTJgzgPQurll38HsFsLk
         Zt1bPUwSPonCPlsGb4g5W0EWu0dg617fM0xVfbip4ka55RHnWACEd3tA9sn9FfmYB4OC
         Qn6Ow6SyuST4f9cxEqTWgUQ/S9LpPrzNdLBFQGpe9JimSn+fTkv8szt+E0KkMfOJHfDS
         tphVduuoDdHSjJAuAIDOkpPBkNCxBcBO6+8YcU/6HB7J9BRhECtcnUAwO7z1+W0nTygE
         Ma5L8WvtNp6Ylb/nnCaMC0hA/TLxGQ8pRB5d/R+j9MZZxx1Q6+UbIbRYbmWZRAEIHkZg
         semQ==
X-Gm-Message-State: AO0yUKUxERROWuWSEoJ4kqZwIX/ER0Sz5mIbdbVUyOEQxEQqJR8Wdfyr
        efouAzMwDuTUDzB/dX3DhN181Q==
X-Google-Smtp-Source: AK7set94fpeAIjPXN6NZi//iCRtc07wp2w+mCY69vOZmLIU9TZUPQC8iGhn0oI3ucQ43cxPSUy1K6w==
X-Received: by 2002:a05:6a00:c84:b0:5a6:cbdc:2a1a with SMTP id a4-20020a056a000c8400b005a6cbdc2a1amr20654537pfv.2.1676345227997;
        Mon, 13 Feb 2023 19:27:07 -0800 (PST)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id v25-20020a62a519000000b005809d382016sm8587299pfm.74.2023.02.13.19.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 19:27:07 -0800 (PST)
Message-ID: <796eb893-f7e2-846c-e75f-9a5774089b8e@igel.co.jp>
Date:   Tue, 14 Feb 2023 12:27:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
 <HE1PR0401MB2331A8D5C791C34D9C39A62688DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <HE1PR0401MB2331A8D5C791C34D9C39A62688DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/02/08 1:02, Frank Li wrote:
>> We project extending this module to support RDMA. The plan is based on
>> virtio-rdma[1].
>> It extends the virtio-net and we are plan to implement the proposed
>> spec based on this patch.
>> [1] virtio-rdma
>> - proposal:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Fall%2F20220511095900.343-1-
>> xieyongji%40bytedance.com%2FT%2F&data=05%7C01%7Cfrank.li%40nxp.co
>> m%7C0ef2bd62eda945c413be08db08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5
>> c301635%7C0%7C0%7C638113625610341574%7CUnknown%7CTWFpbGZsb3d
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
>> 3D%7C3000%7C%7C%7C&sdata=HyhpRTG8MNx%2BtfmWn6x3srmdBjHcZAo
>> 2qbxL9USph9o%3D&reserved=0
>> - presentation on kvm forum:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fyout
>> u.be%2FQrhv6hC_YK4&data=05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62
>> eda945c413be08db08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>> 7C0%7C638113625610341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=ucOsGR1letTjxf0gKN6uls5y951CXaIspZtLGnASEC8%3D&res
>> erved=0
>>
> Sorry for our outlook client always change link.  This previous discussion.
> https://lore.kernel.org/imx/d098a631-9930-26d3-48f3-8f95386c8e50@ti.com/T/#t
>
> Look like Endpoint maintainer Kishon like endpoint side work as vhost.
> Previous  Haotian Wang submit similar patches, which just not use eDMA, just use memcpy.
> But overall idea is the same.
>
> I think your and haotian's method is more reasonable for PCI-RC EP connection.
>
> Kishon is not active recently.   Maybe need Lorenzo Pieralisi and Bjorn helgass's comments
> for overall directions.
I think so too. Thank you for your summarization. I've commented on the 
e-mail.
> Frank Li
>
>> Please feel free to comment and suggest.
>>> Frank Li
>>>
>>>> To realize the function, this patchset has few changes and introduces a
>>>> new APIs to PCI EP framework related to virtio. Furthermore, it device
>>>> depends on the some patchtes that is discussing. Those depended
>> patchset
>>>> are following:
>>>> - [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous
>> transfer
>>>> link:
>>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> %2F&data=05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
>> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
>> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=d
>> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=0
>>>> ernel.org%2Fdmaengine%2F20221223022608.550697-1-
>>>>
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
>>>> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>>>>
>> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=tIn0MHzEvrdxaC4KKTvTRvYXBzQ6MyrFa2GXpa3ePv0%3D&
>>>> reserved=0
>>>> - [RFC PATCH 0/3] Deal with alignment restriction on EP side
>>>> link:
>>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> %2F&data=05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
>> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
>> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=d
>> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=0
>>>> ernel.org%2Flinux-pci%2F20230113090350.1103494-1-
>>>>
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
>>>> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>>>>
>> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=RLpnDiLwfqQd5QMXdiQyPVCkfOj8q2AyVeZOwWHvlsM%3
>>>> D&reserved=0
>>>> - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
>>>> link:
>>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> %2F&data=05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
>> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
>> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=d
>> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=0
>>>> ernel.org%2Fvirtualization%2F20230202090934.549556-1-
>>>>
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
>>>> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>>>>
>> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=6jgY76BMSbvamb%2Fl3Urjt4Gcizeqon%2BZE5nPssc2kDA%
>>>> 3D&reserved=0
>>>>
>>>> About this patchset has 4 patches. The first of two patch is little changes
>>>> to virtio. The third patch add APIs to easily access virtio data structure
>>>> on PCIe Host side memory. The last one introduce a virtio-net EP device
>>>> function. Details are in commit respectively.
>>>>
>>>> Currently those network devices are testd using ping only. I'll add a
>>>> result of performance evaluation using iperf and etc to the future version
>>>> of this patchset.
>>>>
>>>> Shunsuke Mie (4):
>>>>    virtio_pci: add a definition of queue flag in ISR
>>>>    virtio_ring: remove const from vring getter
>>>>    PCI: endpoint: Introduce virtio library for EP functions
>>>>    PCI: endpoint: function: Add EP function driver to provide virtio net
>>>>      device
>>>>
>>>>   drivers/pci/endpoint/Kconfig                  |   7 +
>>>>   drivers/pci/endpoint/Makefile                 |   1 +
>>>>   drivers/pci/endpoint/functions/Kconfig        |  12 +
>>>>   drivers/pci/endpoint/functions/Makefile       |   1 +
>>>>   .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
>>>>   .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635
>> ++++++++++++++++++
>>>>   drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
>>>>   drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
>>>>   drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
>>>>   drivers/virtio/virtio_ring.c                  |   2 +-
>>>>   include/linux/pci-epf-virtio.h                |  25 +
>>>>   include/linux/virtio.h                        |   2 +-
>>>>   include/uapi/linux/virtio_pci.h               |   2 +
>>>>   13 files changed, 1590 insertions(+), 2 deletions(-)
>>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
>>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
>>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
>>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
>>>>   create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
>>>>   create mode 100644 include/linux/pci-epf-virtio.h
>>>>
>>>> --
>>>> 2.25.1
>> Best,
>> Shunsuke

Best,

Shunsuke.

