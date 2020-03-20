Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38E18C7E9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 08:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCTHEg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 03:04:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTHEf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 03:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G2UnEglj8fZW+0J6m8F/lhP/qcPm0/Guw33QlVUVV+8=; b=O/YqoQA3MX8XRNRxBtJYAcqiAl
        /27ULLZGR6XdKmX8cjHa+GHhsEmlwrE1ziBymcm7JPpisMvC1jNG3BvQdL5lpoM/YgCqMUtaO5YZd
        ue9KKKRc5AG8DovkzlROWfHU7AOLCWFXifnyoVuJSjj80ssiYNh9W0pY3WDfRl0UcCe+JWEA+Bs7N
        Mchzu3a8rnOeJP+q4Y3VUucc8pkuZVl6PZdQG8sw2vayw2OIVG9kO/yVuwNrTLvW7FgdqxGyybsTa
        8SlAsUVT+76vdtqVHfUE8QQjzkIIV6yT30wnU/Oflxyystl4PlnPuAbSoG9tlvmz8y0mcnhr7BBwq
        rzcrwuLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFBhq-000197-0A; Fri, 20 Mar 2020 07:04:34 +0000
Date:   Fri, 20 Mar 2020 00:04:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5] PCI: Microchip: Add host driver for Microchip PCIe
 controller
Message-ID: <20200320070433.GA3285@infradead.org>
References: <20200319154917.GA1232@IRE-LT-TRAIN04.mchp-main.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319154917.GA1232@IRE-LT-TRAIN04.mchp-main.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 19, 2020 at 03:49:18PM +0000, Daire McNamara wrote:
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> --
> This v5 patch series adds support for PCIe IP block on Microchip PolarFire SoC.

IIRC Arnd mentioned that the driver could reuse a lot of generic
code first time it was posted, but I don't remember the details.
Adding Arnd to see if he remembers.
