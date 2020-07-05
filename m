Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03726214F6E
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jul 2020 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgGEUkD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jul 2020 16:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgGEUkD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2020 16:40:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59156C061794;
        Sun,  5 Jul 2020 13:40:03 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D83C5846;
        Sun,  5 Jul 2020 20:40:02 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:40:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH 0/4] Documentation: PCI: eliminate doubled words
Message-ID: <20200705144001.07ec8bf4@lwn.net>
In-Reply-To: <20200703212156.30453-1-rdunlap@infradead.org>
References: <20200703212156.30453-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  3 Jul 2020 14:21:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix doubled (duplicated) words in Documentation/PCI/.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Linas Vepstas <linasvepstas@gmail.com>
> 
>  Documentation/PCI/endpoint/pci-endpoint-cfs.rst |    2 +-
>  Documentation/PCI/endpoint/pci-endpoint.rst     |    2 +-
>  Documentation/PCI/pci-error-recovery.rst        |    2 +-
>  Documentation/PCI/pci.rst                       |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
Applied, thanks.

jon
