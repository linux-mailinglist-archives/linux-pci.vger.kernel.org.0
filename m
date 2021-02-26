Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8932648E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Feb 2021 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBZPNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Feb 2021 10:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBZPNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Feb 2021 10:13:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D9B764EC0;
        Fri, 26 Feb 2021 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614352358;
        bh=n7w9qkBiteyMGHBPhW+95R9XdkHKd3796bUZi7qxMec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mU7ezZVSvjjRwwbYBOt7DI1VpTB9ivK0ztc0mMRW/OGi4vGLPC+2z+5gz0ixa2I6e
         mSZGYattvTO1pMWNilRqiMdBjljbFYwHb7XE/PABNtYpt9B1LiTnXaPJZ2cVRHyeVf
         S1ua+RR6aYFnPJl3tkDzLX7qKo+Cke5+XlcPTL0hCfGX9EuUnetDFDIjNu6jbSLyD4
         X+VaNQn9TgEglkzdFw2VYLwIkMnbRDfhKVJpC4Ay1MeHXZOtTfVMgoRhKO5ww9fFEh
         77TBXWYZ2zTwoURHVse/4Bhh5usNsy4kywqlFDrHcIJFjNunN8VLtQPLfBI9uf0xtg
         9NkKkhuaEa+ow==
Date:   Fri, 26 Feb 2021 16:12:31 +0100
From:   Robert Richter <rric@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: controller: thunder: fix compile testing
Message-ID: <YDkP3xwbKi1Cp6aX@rric.localdomain>
References: <20210225143727.3912204-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225143727.3912204-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25.02.21 15:37:09, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compile-testing these drivers is currently broken. Enabling
> it causes a couple of build failures though:
> 
> drivers/pci/controller/pci-thunder-ecam.c:119:30: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> drivers/pci/controller/pci-thunder-pem.c:54:2: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
> drivers/pci/controller/pci-thunder-pem.c:392:8: error: implicit declaration of function 'acpi_get_rc_resources' [-Werror,-Wimplicit-function-declaration]
> 
> Fix them with the obvious one-line changes.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Robert Richter <rric@kernel.org>

> ---
>  drivers/pci/controller/pci-thunder-ecam.c |  2 +-
>  drivers/pci/controller/pci-thunder-pem.c  | 13 +++++++------
>  drivers/pci/pci.h                         |  6 ++++++
>  3 files changed, 14 insertions(+), 7 deletions(-)
