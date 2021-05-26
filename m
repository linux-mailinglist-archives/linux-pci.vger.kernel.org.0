Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC48A391D06
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhEZQa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 12:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233212AbhEZQa1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 12:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3AC3613CE;
        Wed, 26 May 2021 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622046536;
        bh=u5Ps/UhGylsaG69nVFPjg/XzH7QxnfjhmXjILBJnvyc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RRfE52h1LPmOI4qxF9YQ2mz3JHVDufWWQrQVb1u4aBtGApbkNFZj0uhQVMiFSOFRA
         O3MZtc7pteR33ylH9ZP0sVRa11t2I0noFF2Q4tCwtI0r+b4JmzNmwY0HT2E0PRx8cK
         zNvSaMtvgiIGP5JQX5s22hWNt5oMveddTl/xHV7qxVB6Kt1POuk8QZurgx7/DrVGTS
         Of3AXXo/acLvoxAotSpDBBJroJOlQgcdrbQ5d4/7CKnyQRXIehAbEvJ7Hzpqeunsmk
         mrzMQhOsRP9fQ3rDDfmFlNfAKzlpoDLz3Q66YRJKrAXTWGtevuh+v1D/naJ+mW0GmW
         8ZaT+disgtv2A==
Date:   Wed, 26 May 2021 11:28:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jon Mason <jdmason@kudzu.us>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: PCIe endpoint network driver?
Message-ID: <20210526162854.GA1300083@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0EhbeBdiuypzAB5FzcNqG3ytT9MJa14BBqF7oCDroaNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Kishon, Jon, Logan, who might have more insight]

On Wed, May 26, 2021 at 08:44:59AM -0700, Tim Harvey wrote:
> Greetings,
> 
> Is there an existing driver to implement a network interface
> controller via a PCIe endpoint? I'm envisioning a system with a PCIe
> master and multiple endpoints that all have a network interface to
> communicate with each other.
> 
> It looks like the PCI Endpoint Framework has a function library but I
> didn't see anything that looked like a network driver.
> 
> Best regards,
> 
> Tim
