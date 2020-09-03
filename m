Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8125C25B7AF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgICAl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 20:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgICAlz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 20:41:55 -0400
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8220D2072A;
        Thu,  3 Sep 2020 00:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599093714;
        bh=o53Qzhg6oCGPQsbUVZSSWaG+9k+dRs8dxC7A2ExLnC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PYG0v04Ej2VL3JNRHSnRXntrFvnrNcCZrKwBRbbNjk0xMmQA8zj0W3v6qlI6SQkuq
         J0xsMLFxxz9ErnYxG0InZfwv4CQBFxzKNiGbgZbmddZWYw1oAwiHrOy+y+n9R1srQz
         5x52TwewfWZitqJMOHgfr2KoR//vmk2zKSIjLP/U=
Date:   Wed, 2 Sep 2020 19:41:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Das, Nirmoy" <Nirmoy.Das@amd.com>,
        "Li, Dennis" <Dennis.Li@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
Message-ID: <20200903004153.GA277699@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4340FC71C17B28E1601EBCDDEA2F0@DM6PR12MB4340.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 11:43:41PM +0000, Grodzovsky, Andrey wrote:
> It's based on v5.9-rc2 but won't apply cleanly since there is a
> significant amount of amd-staging-drm-next patches which this was
> applied on top of.

Is there a git branch published somewhere?  It'd be nice to be able to
see the whole thing, including the bits that this depends on from
amd-staging-drm-next.
