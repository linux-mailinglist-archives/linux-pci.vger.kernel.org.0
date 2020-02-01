Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12614F55E
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2020 01:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgBAAYb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 19:24:31 -0500
Received: from ale.deltatee.com ([207.54.116.67]:49500 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgBAAYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 19:24:30 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ixgaK-0001fZ-9J; Fri, 31 Jan 2020 17:24:29 -0700
To:     Andrew Maier <andrew.maier@eideticom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200201002307.4520-1-andrew.maier@eideticom.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cc3a48ce-89f0-f909-d9eb-69d71a6abcc1@deltatee.com>
Date:   Fri, 31 Jan 2020 17:24:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200201002307.4520-1-andrew.maier@eideticom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, andrew.maier@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Add the Intel Sky Lake-E root ports to the
 whitelist
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-01-31 5:23 p.m., Andrew Maier wrote:
> Add the four Intel Sky Lake-E host root ports to the whitelist of
> p2pdma.
> 
> P2P has been tested and is working on this system.
> 
> Signed-off-by: Andrew Maier <andrew.maier@eideticom.com>

Looks good to me, Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
