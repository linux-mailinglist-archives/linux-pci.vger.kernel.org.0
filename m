Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3619A88903
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2019 09:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfHJHRY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Aug 2019 03:17:24 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:41851 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfHJHRY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Aug 2019 03:17:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D643A4A3;
        Sat, 10 Aug 2019 03:17:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 10 Aug 2019 03:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=dWalkSo5U5zBSrxbSItXiHW8n4n
        ady+uCrDU+Qbz3Jo=; b=COG6UMOq/dCApaWjynhYcx+bWmw8a2eYBZ5gNi+8df7
        ZvGXo6lIjg6K68gXehfJZcwdh6o1R8aVYrRBlu+97k9qv4YORbiNVvHaAfQzlfRk
        bmEsgl1QFrGL1LJ8hQkMJbd2it9YPQBpndlGuO1PLTUhwQdthKS0e5WXVCIjaMMD
        +noUU+ufDRFloMuMtpkVuNzBIpaoFCjvkqdeNvGlxeh0u19vQlE2v8hri9wHF1kH
        Aq0BSTSjDhsfLlvQlrFOW38r/FCmk7NLBQ9bXqxt6MfYCjbv/Qyyw4hh5yyOQRpv
        RsaRR7DpOTIRmnwZnuPPeeKFY3q1xqbp2b40s7sGn0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dWalkS
        o5U5zBSrxbSItXiHW8n4nady+uCrDU+Qbz3Jo=; b=miTPS+pxsqXH1yVsbn+Jmy
        wyf7j8VQzoqfz7VHYY2nL1PYP8rvNRA5HZgijy+A2i++pqsbJM+jYfsbImNysGHk
        CQwibWBjbT9WRYVakfYgX2qKcf/CwiFWchJjROTHVmn9YAqccJ/u+8p+gRpu1jbD
        S0rofUMB18QJgm1dyqcVc0U5LM0N+KHi7nc5I0FbPYKT2AgOpxW3XUqnLu5U/zm1
        P5xKERXDEc6fX7SuXYbZyZa11hRqtYtc0p42SUf2wT5TOw6BL5fpHJAAQTMYuCLX
        GMoggjvcWFytxKLBJBekzbqWpLMZ4OZDPczg2q1qNST4obhL01ClV3+E5DfiVjuw
        ==
X-ME-Sender: <xms:gm9OXYcNpmNryiD9ESGyXafphLp_tw0fejVw0PgAdxdv-8GbuTAalA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddukedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gm9OXWj5-elLSAL06KojkDOHZYcWog7ILr5UF-CU8ZE33khEWWgmJg>
    <xmx:gm9OXcSqYWDeqAdCHkC7aaYWnjcBTC7Jtw-fTxptqnGvNnU-xLFKKQ>
    <xmx:gm9OXfxsRQYfH7EJPEf70kT3bdKi61UkIq_a871u6EX50Wlf09mMvA>
    <xmx:gm9OXSuX-qiL7_cELu-MpUBV570FbDPHoYL2LnZMlQjfEDvUlLWCxA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE0778005A;
        Sat, 10 Aug 2019 03:17:21 -0400 (EDT)
Date:   Sat, 10 Aug 2019 09:17:19 +0200
From:   Greg KH <greg@kroah.com>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI/IOV: Move sysfs SR-IOV
 functions to iov.c
Message-ID: <20190810071719.GA16356@kroah.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 01:57:21PM -0600, Kelsey Skunberg wrote:
> +static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);

DEVICE_ATTR_RO() please.  This is a device attribute, not a "raw"
kobject attribute.

> +static struct device_attribute sriov_numvfs_attr =
> +		__ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> +		       sriov_numvfs_show, sriov_numvfs_store);
> +static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> +static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> +static struct device_attribute sriov_vf_device_attr =
> +		__ATTR_RO(sriov_vf_device);
> +static struct device_attribute sriov_drivers_autoprobe_attr =
> +		__ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> +		       sriov_drivers_autoprobe_show,
> +		       sriov_drivers_autoprobe_store);

Same for all of these, they should use DEVICE_ATTR* macros.

And why the odd permissions on 2 of these files?  Are you sure about
that?

thanks,

greg k-h
