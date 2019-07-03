Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8C5EF47
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 00:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGCWyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 18:54:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:40579 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfGCWyW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 18:54:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x63Ms7Z4012251;
        Wed, 3 Jul 2019 17:54:08 -0500
Message-ID: <b73eb3ecf37cec8761e9e62d14a35e7eddd62fd1.camel@kernel.crashing.org>
Subject: Re: Multitude of resource assignment functions
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Thu, 04 Jul 2019 08:54:07 +1000
In-Reply-To: <SL2P216MB01878623FC34BC4894EB495280FB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
         <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
         <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
         <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
         <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
         <SL2P216MB0187E659CFF6F9385E92838680FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <20190702213951.GF128603@google.com>
         <SL2P216MB01878623FC34BC4894EB495280FB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-07-03 at 13:43 +0000, Nicholas Johnson wrote:
> The nocrs is vital because the BIOS places pitiful space behind the root 
> complex and will fail for assigning large BARs - hence why Xeon Phi 

Can you check what you get out of _DSM #5 behind these if it exists ?

Cheers
Ben.

