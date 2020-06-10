Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E121F4EA8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgFJHNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 03:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgFJHNe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 03:13:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D76C62081A;
        Wed, 10 Jun 2020 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591773213;
        bh=9/XwdMFddmKG/Fg7fia56TYy7QMv+4JQHM/sDjaOilE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rf0RY8JQZEHZC+ruF/Fmpwo8bggVSbfuKiBGRBd9upWHm1PNCm/oveJSLSO/MD1u4
         zatapG6vPJVr6SrFN9U4IaU3kBi/U9XqsWNNpqp/vcBczYnY2qrO4t0f75TUjJ/ybr
         k9cXW6PxpM+jFMNMGX2JjyymnWnbtmdscrI5k1J0=
Date:   Wed, 10 Jun 2020 09:13:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200610071331.GD1923109@kroah.com>
References: <20200607113632.GA49147@kroah.com>
 <20200609210400.GA1461839@bjorn-Precision-5520>
 <CACK8Z6E0s-Y207sb-AqSHVB7KmhvDgJQFFaz6ijQ_0OS3Qjisw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6E0s-Y207sb-AqSHVB7KmhvDgJQFFaz6ijQ_0OS3Qjisw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 04:23:54PM -0700, Rajat Jain wrote:
> The one thing that still needs more thought is how about the
> "pcieport" driver that enumerates the PCI bridges. I'm unsure if it
> needs to be whitelisted for further enumeration downstream. What do
> you think?

Why not just do whatever type of "code review" you need to do for that
one core driver to get that off of your "drivers to worry about" list?
:)

thanks,

greg k-h
