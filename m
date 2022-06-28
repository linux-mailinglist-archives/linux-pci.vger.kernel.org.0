Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3355D9D2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbiF1Lrt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 28 Jun 2022 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345366AbiF1Lr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 07:47:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA303B0F;
        Tue, 28 Jun 2022 04:47:23 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXN5N1f3kz682jJ;
        Tue, 28 Jun 2022 19:43:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 13:47:21 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 12:47:20 +0100
Date:   Tue, 28 Jun 2022 12:47:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 02/46] cxl/port: Keep port->uport valid for the entire
 life of a port
Message-ID: <20220628124718.000023f8@Huawei.com>
In-Reply-To: <165603871491.551046.6682199179541194356.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603871491.551046.6682199179541194356.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 19:45:14 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The upcoming region provisioning implementation has a need to
> dereference port->uport during the port unregister flow. Specifically,
> endpoint decoders need to be able to lookup their corresponding memdev
> via port->uport.
> 
> The existing ->dead flag was added for cases where the core was
> committed to tearing down the port, but needed to drop locks before
> calling device_unregister(). Reuse that flag to indicate to
> delete_endpoint() that it has no "release action" work to do as
> unregister_port() will handle it.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")

From the explanation I'm not seeing why this has a fixes tag?

Otherwise seems fine...


> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/port.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index dbce99bdffab..7810d1a8369b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -370,7 +370,7 @@ static void unregister_port(void *_port)
>  		lock_dev = &parent->dev;
>  
>  	device_lock_assert(lock_dev);
> -	port->uport = NULL;
> +	port->dead = true;
>  	device_unregister(&port->dev);
>  }
>  
> @@ -857,7 +857,7 @@ static void delete_endpoint(void *data)
>  	parent = &parent_port->dev;
>  
>  	device_lock(parent);
> -	if (parent->driver && endpoint->uport) {
> +	if (parent->driver && !endpoint->dead) {
>  		devm_release_action(parent, cxl_unlink_uport, endpoint);
>  		devm_release_action(parent, unregister_port, endpoint);
>  	}
> 

