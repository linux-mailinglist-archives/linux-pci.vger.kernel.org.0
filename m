Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD677AE6BF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 09:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjIZH01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 03:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZH00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 03:26:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63FFC;
        Tue, 26 Sep 2023 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NznSBD2uteqB9qxa+hTMt7JkHTRzuMUHjjRchlfeKyg=; b=G7bzPPhTZKVUlgbOowLdMfh/WB
        A4eCYjDlDRP6tO7FUtuNHGSvEtsgZokP3NWpYBEdnape2papZwgcJt1Lza12XveBTwAcfsF8DnrjQ
        JjWf4X1ePyTmIhod9yExdhzkMCEOlkF7hXx5iOPtJHjDTDp6GmuPrCVtxmX5GYEJc5BhJSVKoZees
        3HZtooXsPnNVTS9mBTyrWrhAHvZrWYkJj+iLjaygtE4EWx1L+hOpvoWkNz3j+n8Gw3uQjhkt0BNwl
        wEF/IItGRkgjPtbVJ3rqR2F97yhP8ZtowC0H56ISriZw3zpMKkLUkCHa2OVQqdpAKR82VRla6TdnW
        bi176l4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ql2SG-00FnBM-1p;
        Tue, 26 Sep 2023 07:26:00 +0000
Date:   Tue, 26 Sep 2023 00:26:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kishon Vijay Abraham I <kvijayab@amd.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, vaishnav.a@ti.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Message-ID: <ZRKHiE9iFuHGUkHV@infradead.org>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
 <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 02:41:54PM +0530, Kishon Vijay Abraham I wrote:
> > PCI Endpoint function driver is implemented using the PCIe Endpoint
> > framework, but it requires physical boards for testing, and it is difficult
> > to test sufficiently. In order to find bugs and hardware-dependent
> > implementations early, continuous testing is required. Since it is
> > difficult to automate tests that require hardware, this RFC proposes a
> > virtual environment for testing PCI endpoint function drivers.
> 
> This would be quite useful and thank you for attempting it! I would like to
> compare other mechanisms available in-addition to QEMU before going with the
> QEMU approach.

Well, the point of PCIe endpoint subsystem in vhost or similar is that
you can use one and the same endpoint implementation.  So you can debug
it using qemu and the use it with a physical port, which would be really
amazing.

