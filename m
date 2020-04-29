Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291691BDA62
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD2LLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 07:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2LLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 07:11:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46125C03C1AD
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2020 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h4yExVpwX/uaCxKDpa4vmf0JEKyk/VAT/udhAYWZ80I=; b=cIe8XB21XPfNVKTyBWegXSn9YL
        8dakv0wGYC6fqB8BWYAYn9tojFPqEf+OCJkKaXJvUgfwbweLGpe2T4vNMYv5rex9kf1/Q0c70otjD
        LObR61n7VsGAYbLsQrpCFH7r6hvZACtGXnx6wKTabn5DtbC/M3Eim3o1+xqmAOCx+EMj91pZt3mxX
        PQVsuPZemCG1BodBUPEncxtQzLlG8BTPfGrhtxcsIHLIe3MtX0UlpjpsznQKnEhDaiw5vajvTq4Wp
        1NCBu9LHB5F2w4PMKP5ZVbMvatl9JP9r0SJSAGMmjUa8qDLnBIPczncteai/6XZOcP2XHnIVOyF/0
        STtQai5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTkca-0005G6-SG; Wed, 29 Apr 2020 11:11:20 +0000
Date:   Wed, 29 Apr 2020 04:11:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daire.McNamara@microchip.com
Cc:     amurray@thegoodpenguin.co.uk, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, helgaas@kernel.org
Subject: Re: [PATCH v8 0/1] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200429111120.GA19649@infradead.org>
References: <a71cee05633ffac508366d66ca23a467716b14b7.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71cee05633ffac508366d66ca23a467716b14b7.camel@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 09:37:49AM +0000, Daire.McNamara@microchip.com wrote:
> This v8 patch adds support for the Microchip PCIe PolarFire PCIe
> controller when configured in host (Root Complex) mode.
> 
> Updates since v7:
> * Build for 64bit RISCV architecture only

why?
