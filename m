Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5A7689557
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 11:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjBCKSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 05:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjBCKST (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 05:18:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7058C9AFC7
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 02:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675419418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ousZpEK5jfyQ8iRq6Lou/eQvak4AKWvj409ge5GqF4=;
        b=ZkWNcPv/uQD+RxJw/BgXs5miSc2OFvlxbO9Kr4rfbVfI0XrY9hv1aZUXj64jeqLJcUscR9
        wetCvqTqhXwadIt4GX4RfGYK0+QMCjW0v72NOIQdlIliJS4NWg0os3Yj4enf/6IG8aELCM
        WiSHPUXi2ID5WiCWgLkf3fZQqEgwgXs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-SfUBAbkCN1y5c0aJFnEJfA-1; Fri, 03 Feb 2023 05:16:51 -0500
X-MC-Unique: SfUBAbkCN1y5c0aJFnEJfA-1
Received: by mail-ed1-f72.google.com with SMTP id s11-20020a056402164b00b004a702699dfaso2960635edx.14
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2023 02:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ousZpEK5jfyQ8iRq6Lou/eQvak4AKWvj409ge5GqF4=;
        b=oqa+dNCb50wU3g9U+wSNd0nVRdwTJABtKV/dI7qNQzsewe1wAC+cwz+OZ0Wa66pgwP
         WZAAsCdN8pBJGQ0EnHccgMAKnpt8QYnX6wqKCldXoHif7H47w6ioY0qL8ccZ5l8myyqf
         3Gg1XVIcl/2rsQpy4nFNOp7Tr8dzxLUkwKIGV6ax5dOeZXrA8Rkq1ndPnFEFHASOF+K8
         Hf9/NQ1TUHx1g3ZWbL565W2X4DTUwhlHxS/9YGfP36QX9g03LshffvuzeqlMefij/quX
         Fzuyu/1geY3LWAP9eh2ivIZFaxbxp8B3FhgCQf8FUX3IzsSpSwpxMV5KHar2AoIBrtwE
         a27g==
X-Gm-Message-State: AO0yUKWtTHep+BJnYVhMI9AHTXxHrUoN8bfLBSmIUManq0JQPzz3iphw
        LNBL9/k2n38lAq7hn7O2CHEqJQ3y6lWRtABa1OLJumjXB2+x9Dx9SCISK6cTW6rOWdzh0Q0y2+R
        EA+zFFWiOh3P0uRdDyP2V
X-Received: by 2002:a17:907:6d17:b0:88d:ba89:1843 with SMTP id sa23-20020a1709076d1700b0088dba891843mr5270795ejc.20.1675419410285;
        Fri, 03 Feb 2023 02:16:50 -0800 (PST)
X-Google-Smtp-Source: AK7set/pKRk6MAe68cqpo58de4wljRgyqSUUvcGRqEx82KpgViv3orGBmWcoaFTcA1tHf3+p9hR8NQ==
X-Received: by 2002:a17:907:6d17:b0:88d:ba89:1843 with SMTP id sa23-20020a1709076d1700b0088dba891843mr5270773ejc.20.1675419410082;
        Fri, 03 Feb 2023 02:16:50 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id cw20-20020a170906c79400b008787c8427c1sm1139542ejb.214.2023.02.03.02.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:16:49 -0800 (PST)
Date:   Fri, 3 Feb 2023 05:16:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH 1/4] virtio_pci: add a definition of queue flag in ISR
Message-ID: <20230203051445-mutt-send-email-mst@kernel.org>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-2-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203100418.2981144-2-mie@igel.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 07:04:15PM +0900, Shunsuke Mie wrote:
> Already it has beed defined a config changed flag of ISR, but not the queue
> flag. Add a macro for it.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> Signed-off-by: Takanari Hayama <taki@igel.co.jp>
> ---
>  include/uapi/linux/virtio_pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..fa82afd6171a 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -94,6 +94,8 @@
>  
>  #endif /* VIRTIO_PCI_NO_LEGACY */
>  
> +/* Ths bit of the ISR which indicates a queue entry update */

typo

Something to add here:
	Note: only when MSI-X is disabled



> +#define VIRTIO_PCI_ISR_QUEUE		0x1
>  /* The bit of the ISR which indicates a device configuration change. */
>  #define VIRTIO_PCI_ISR_CONFIG		0x2
>  /* Vector value used to disable MSI for queue */
> -- 
> 2.25.1

