Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA441712085
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 08:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjEZGzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 02:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjEZGzO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 02:55:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49D95
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2023 23:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vKzQlhcxkkMQoEfvC17xC/R7J7Er0cfz4WtFMuyrbs8=; b=dnAYnsr9eJUK36/YqKROOcjok7
        Y6ihOcpYfhW2J/pvOgP+eBXvG9Dm3VsVJhwM5Hu0S45bkXohWI7ckNFaeMdKR2h6pkvoS35pxqbYh
        0Or60z7pNg/fkozMkKVbLBxIrG6WIq8AHG5xVZAdIDfZlD7KOvGNaTdesCAx89kGB6UfrAY6YdbaR
        9movQHme2dhEi7AcAhlQZmmohz+gnzIIeTJZrQJFuDPJSw/lV0jy/z+zYdLOUXZR3+9bFOLP8u2DI
        /gLXN3AQlQHzU4Nj4aqM55x9u222DtlDzoP/bg7PHj9tVcHOIr3xiPuyZ4EPV6yOUoDwEehWMXxdP
        fYog8VpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2RLw-001KMS-1q;
        Fri, 26 May 2023 06:55:08 +0000
Date:   Thu, 25 May 2023 23:55:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Zhang, Morris" <Shiwu.Zhang@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: add the accelerator pcie class
Message-ID: <ZHBXzItiT1+OSsjX@infradead.org>
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
 <ZGxfEklioAu6orvo@infradead.org>
 <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
 <ZG8ud4JWpF7BXJ7c@infradead.org>
 <BL1PR12MB5144DDA502D52040945DFC4BF7469@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB5144DDA502D52040945DFC4BF7469@BL1PR12MB5144.namprd12.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 25, 2023 at 08:52:06PM +0000, Deucher, Alexander wrote:
> We already handle this today for CLASS_DISPLAY via a data table provided on our hardware that details the components on the board.  The driver can then determine whether or not that combination of components is supported.  If the data table doesn't exist or isn’t parse-able, or the components enumerated are not supported, the driver doesn't load.

But things like module loading and initramfs generation still work
off the ID table and not your internal tables.

