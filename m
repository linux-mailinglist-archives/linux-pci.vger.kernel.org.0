Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDCF7B5B02
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 21:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJBTGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjJBTG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 15:06:28 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE0DE3
        for <linux-pci@vger.kernel.org>; Mon,  2 Oct 2023 12:06:25 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id nMWHqi8ZsytxcnOFMq6oMW; Mon, 02 Oct 2023 19:06:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id nOFLqdaDkl3uanOFLqzIsw; Mon, 02 Oct 2023 19:06:24 +0000
X-Authority-Analysis: v=2.4 cv=B4yqbchM c=1 sm=1 tr=0 ts=651b14b0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=nVEl-0sjCtjp5Y-AIcoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X4e+5MdOuAxyi1+BhwS40SNlhSsKv6QuIxy7lXc9Mlk=; b=BADl0hdVjaox9SM9t9ZEc0DN0f
        AR6YR/t/fvSb31WnWzZ0o0X+I9lzg0+7knj1LAuFD1Rn2RC96A0fFIrkAVrYgSe3jhirvy5F9fEQP
        MkSfhLaUoDM+6dtjdQvf5WeVRefXeDDU2muukX3ikalynfFHfbCRVcbcOS99/P0OUGHHAlRnPe+FW
        gG665kE1edNnxrVqUhpVIzFTguU0GbAe35a1aBlFkHbTLBTYNYErhyMoXf0mltKJoh2Isi7/sDXfR
        66TY9IhSdySSUMrzwx+RzY+vsKoCWhoOXrIzuikuG0unyXaW6Lg2AQbgZkjStWx2fPXLLt6oAtN2N
        NSm/waDQ==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:54352 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnOFL-003sIs-0L;
        Mon, 02 Oct 2023 14:06:23 -0500
Message-ID: <446f6c02-a914-cc00-2dea-478fbed898c6@embeddedor.com>
Date:   Mon, 2 Oct 2023 21:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH][next] PCI/P2PDMA: Fix undefined behavior bug in struct
 pci_p2pdma_pagemap
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZRnf6wVOu0IJQ2Ok@work>
 <29da763d-1570-7197-2d5a-03c5659b8b52@deltatee.com>
 <734c7fdf-4c41-2890-dbe7-ddb23fd6bcc7@embeddedor.com>
 <e76ff7de-8c42-4393-36e2-b37ffcb58149@deltatee.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <e76ff7de-8c42-4393-36e2-b37ffcb58149@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qnOFL-003sIs-0L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:54352
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCSXwD8Bs5q+GGpoiqH5LrpHNIge5ttHRUkc1fNGBvJYGX8GS/sQ257cEnEUvOoOrh3twtJA7aOeQiFOKpJQzOG6zqiqf32AZZwRtJY4EMPhX6hbPFrd
 WUGy5ho9z2gXXOZrc50fcHoi1ZHWoZwRUXkoFWqr3jZ7I+zMzwGyoRTlUAmXkGo6Kqi5q+uigzXQr2RGc+O9V4bCtTvKScGgKio=
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> 
> Yes, but the commit message is not clear that nr_range can never be >1
> in the code as it currently is.

Done:
	https://lore.kernel.org/linux-hardening/ZRsUL%2FhATNruwtla@work/

Thanks!
--
Gustavo
