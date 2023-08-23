Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8778579F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 14:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjHWMKq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Aug 2023 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjHWMKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 08:10:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF31716;
        Wed, 23 Aug 2023 05:10:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RW4lH6Syfz67QqC;
        Wed, 23 Aug 2023 20:09:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 13:10:14 +0100
Date:   Wed, 23 Aug 2023 13:10:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alistair Francis <alistair23@gmail.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Damien Le Moal <dlemoal@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
        <christian.koenig@amd.com>, <kch@nvidia.com>,
        <gregkh@linuxfoundation.org>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
        <rdunlap@infradead.org>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230823131013.000005b9@Huawei.com>
In-Reply-To: <CAKmqyKMRxN68N_29HjEDb2UVU+_RyAc7Z7+iouHP_xq3f_UX0g@mail.gmail.com>
References: <20230810163342.1059509-1-alistair.francis@wdc.com>
        <b3d437f5-fe33-4677-e336-a67ac9b8d477@kernel.org>
        <20230812082108.GD9469@wunner.de>
        <CAKmqyKMRxN68N_29HjEDb2UVU+_RyAc7Z7+iouHP_xq3f_UX0g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 15 Aug 2023 14:36:31 -0400
Alistair Francis <alistair23@gmail.com> wrote:

> On Sat, Aug 12, 2023 at 4:21 AM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Fri, Aug 11, 2023 at 10:03:58AM +0900, Damien Le Moal wrote:  
> > > On 8/11/23 01:33, Alistair Francis wrote:  
> > > > Each DOE feature is exposed as a single file. The files are empty and
> > > > the information is contained in the file name.  
> > >
> > > s/feature/protocol ?  
> >
> > DOE r1.1 replaced all occurrences of "protocol" with the term "feature"
> > or "Data Object Type".
> >
> > PCIe r6.1 (which was published July 24) incorporated that change.
> >
> > So going forward the term "protocol" is deprecated in the DOE context.
> >
> > We should use the terms used by the (latest) PCIe Base Spec so that
> > users can easily make the connection between the language in the spec
> > and our code.
> >
> > Unfortunately this patch uses a mix of "protocol" and "feature".
> > It should use the latter term exclusively.  
> 
> The existing file uses protocols, so I have tried to match the
> existing style. I have changed the names to feature though

Feel free to fix the rest of the file as a precursor ;)

Jonathan

> 
> Alistair
> 
> >
> > Thanks,
> >
> > Lukas  

