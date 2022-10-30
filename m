Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E842612919
	for <lists+linux-pci@lfdr.de>; Sun, 30 Oct 2022 09:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ3I2X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Oct 2022 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ3I2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2022 04:28:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACABB267
        for <linux-pci@vger.kernel.org>; Sun, 30 Oct 2022 01:28:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A7EC68AA6; Sun, 30 Oct 2022 09:28:19 +0100 (CET)
Date:   Sun, 30 Oct 2022 09:28:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Michon <amichon@kalrayinc.com>
Cc:     michael.haeuptle@hpe.com,
        CS1PR8401MB07283E5AFD950C136FFC565E95C60@cs1pr8401mb0728.namprd84.prod.outlook.com,
        dstein@hpe.com, hch@lst.de, linux-pci@vger.kernel.org,
        lukas@wunner.de
Subject: Re: Deadlock during PCIe hot remove
Message-ID: <20221030082818.GB4949@lst.de>
References: <492110694.79456.1666778757292.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492110694.79456.1666778757292.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 26, 2022 at 12:05:57PM +0200, Alex Michon wrote:
> Hello, 
> 
> Is there any update on this bug ? 

What is "this bug"?
