Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951ED4B82BC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 09:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiBPIOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 03:14:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiBPIOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 03:14:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEEB251E6C;
        Wed, 16 Feb 2022 00:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eK7JQP3AD1+05eQk/cFJFk4JohXRVweM/+B5FTB73ng=; b=SvNQmY6s0tTSr74RpoPjpXFknN
        +ih/jXI0aVHS0v3cvv4SeAQUyxAkHesXys2OtGPFSpuO1g7lhDeXluXHsYHr6jbsd4LKXsV+I+EDS
        mwITAK1Hdq6ubXuCm+ukvvLFAzw7wkLOUZOVz7PtfrjAMFJvmn0abE44k8/+98JjKBk+OHOA5WwLm
        M5oRguh70Q5PNjzWhuHMWz4DS8yE7lugU+fx4oC7wzXq9Fqs833hNE19gwmTP31llnRs6XSduqhoE
        6lVEAooGgzrhF3wUVQz6yZjdhocY2PL+tiQzXzgTtfu+hQ2rkmzkB7ls/4peyTwp1OTzsa9X+Zcy4
        U6RQMGcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKFS2-0063dZ-Js; Wed, 16 Feb 2022 08:14:14 +0000
Date:   Wed, 16 Feb 2022 00:14:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
Message-ID: <YgyyVtDVV+0Jrogi@infradead.org>
References: <CAJZ5v0i6+EMMGuKckhtTdt7TgC3LbofW7oS7B5=McSNjEh1yKA@mail.gmail.com>
 <20220216015303.GA137820@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216015303.GA137820@bhelgaas>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 07:53:03PM -0600, Bjorn Helgaas wrote:
> Apparently there's a firmware toggle, but I don't know exactly what it
> does.  Maybe if the toggle is set to disable VMD, the VMD device looks
> like a regular Root Port and the devices below are enumerated
> normally even without any vmd.c?

Yes.  VMD is just an intel invention to make the OSes life incredibly
painful (and to allow Intel to force binding their NVMe driver instead
of the Microsoft one on windows).
