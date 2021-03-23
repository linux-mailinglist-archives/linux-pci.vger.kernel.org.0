Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4943461DE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhCWOvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 10:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhCWOv2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 10:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A837661983;
        Tue, 23 Mar 2021 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616511087;
        bh=hgxdo4ZUUEitXDWs4Mlm83kBINAI4vjmbUS8R5zTyqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpkg1HfJVEeaaDXnvy5P0QTofpqOzmmn+SKtNcOu2q3IhyXJwQeuYGE67ash+xPIQ
         F2y6BUnNTPHMx2lKgxOhZp4jHt4kjeTOLU0+3Fg1R7nhf0tdwAOIW6IXpArC90p+yY
         IJjQ6k3C7boc8ebEQnNqMLvgV4L9YQEUALU2By0e3GSty8Po/2cDJu7Nmh16qV+HQZ
         TyU8ox0nbEJovwHDkfE1+LIvayUVp8IJi4DUUA98ZL+m4v7SqMtSQ4Hali2r4EhHds
         ungF7YHvoHMVHuuErZziga+H2O4R31eqQGDSd8XLaQ7DGOgfUlqcmqWii42A4KNG4s
         kG2GTIRddU7uA==
Received: by pali.im (Postfix)
        id 2283192C; Tue, 23 Mar 2021 15:51:25 +0100 (CET)
Date:   Tue, 23 Mar 2021 15:51:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
Message-ID: <20210323145124.6myowqcjga5ro2pn@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-4-jianjun.wang@mediatek.com>
 <20210311123844.qzl264ungtk7b6xz@pali>
 <1615621394.25662.70.camel@mhfsdcap03>
 <20210318000211.ykjsfavfc7suu2sb@pali>
 <1616046487.31760.16.camel@mhfsdcap03>
 <20210319185341.nyxmo7nwii5fzsxc@pali>
 <1616463094.25961.8.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616463094.25961.8.camel@mhfsdcap03>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 23 March 2021 09:31:34 Jianjun Wang wrote:
> One more question, is there any chance that we can put this linkup flow
> to a more "standard" way, such as drivers provides the ops of the PERST#
> pin and let the framework to decide how to start a link training, or we
> just use macro to replace this timeout value in the future?

This is something about which I was thinking that could be useful for
pci-aardvark.c driver. But I was not sure if some other driver can
benefit from such "framework". But now I see that your driver is another
candidate which can benefit from it.

Currently there is no such "framework" in kernel and the hardest part
would be to design it.

Having this API would allow kernel to implement and export PCIe Warm
Reset (which is done via PERST# signal) and easily extend Amey's reset
patches to export also Warm Reset via sysfs.

But to implement this framework and using it for reset we first need to
answer questions which I have sent in email:
https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/

Bjorn, Alex: any opinion about PERST#?

Also see Enrico's email, where confirmed that there are platforms which
shares one PERST# signal for more endpoint cards:
https://lore.kernel.org/linux-pci/1da0fa2c-8056-9ae8-6ce4-ab645317772d@metux.net/
