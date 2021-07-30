Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07F63DB2A1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 07:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhG3FOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 01:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234928AbhG3FOd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 01:14:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 068D260F6B;
        Fri, 30 Jul 2021 05:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627622069;
        bh=cQIElo1E9fKELuitkzz4Nnlpr5A93y3/A/fg6zeS8js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRyiJL/yy3aEggTIbOtAR8L8bi6PL7dPXoLRl5r49EOhGZXp5mn5CKNLv9yhmRMnE
         Ndrw4I3b507w5H5Q/dR9ROYzh5NveqnifYFn2gxZGDkR3Q1i3rOQhEEYLQoryY7/+6
         e4MTnyZavPfa+Fj4XExUtq7Il81FKpkhEKs9r3WM=
Date:   Fri, 30 Jul 2021 07:14:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel@pengutronix.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 5/5] PCI: Drop duplicated tracking of a pci_dev's
 bound driver
Message-ID: <YQOKs8Lsk8Rej5W2@kroah.com>
References: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
 <20210729203740.1377045-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729203740.1377045-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 10:37:40PM +0200, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I know I can not take patches without any changelog text, maybe other
maintainers are more lax :(

