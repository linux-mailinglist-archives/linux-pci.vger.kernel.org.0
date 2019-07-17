Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1346C24C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2019 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGQUsz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jul 2019 16:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfGQUsz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jul 2019 16:48:55 -0400
Received: from localhost (unknown [113.157.217.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A5A21872;
        Wed, 17 Jul 2019 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563396534;
        bh=HFcP5RNFS00iwTt5cs4vem876Sjre5FFFdjEoA1hn0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eyjdxdf6VUfM6vQ3mjTpAUd3cVambWAdql0lTDA7UMiti0oZ61KrCDswooxodZpYg
         E5m8mKlyV9Kd6B/HF14DS/l0c2k0umWyBNBvBY4IUmQaN/7zjmCXjg/HfivisiVJBJ
         Q3K2BUzdL91+zBhmYEWN/Gi9Ib9vySICzaGeBxiY=
Date:   Thu, 18 Jul 2019 05:48:53 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI: Remove unused
 EXPORT_SYMBOL()s from drivers/pci/bus.c
Message-ID: <20190717204853.GD12367@kroah.com>
References: <20190717182353.45557-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717182353.45557-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 17, 2019 at 12:23:53PM -0600, Kelsey Skunberg wrote:
> pci_bus_get() and pci_bus_put() are not used by a loadable kernel module
> and do not need to be exported. Remove lines exporting pci_bus_get() and
> pci_bus_put().
> 
> Functions were exported in commit fe830ef62ac6 ("PCI: Introduce
> pci_bus_{get|put}() to manage PCI bus reference count"). No found history
> of functions being used by a loadable kernel module.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
