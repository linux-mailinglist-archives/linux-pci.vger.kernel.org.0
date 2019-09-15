Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D4B3103
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2019 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfIORAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Sep 2019 13:00:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44412 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfIORAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Sep 2019 13:00:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9XYh-00032u-0f; Sun, 15 Sep 2019 16:39:31 +0000
Date:   Sun, 15 Sep 2019 17:39:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: pci: endpoint test BUG
Message-ID: <20190915163930.GX1131@ZenIV.linux.org.uk>
References: <5d9eda26-fb92-063e-f84d-7dfafe5d6b29@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9eda26-fb92-063e-f84d-7dfafe5d6b29@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 15, 2019 at 09:34:37AM -0700, Randy Dunlap wrote:
> Kernel is 5.3-rc8 on x86_64.
> 
> Loading and removing the pci-epf-test module causes a BUG.

Ugh...  Could you try to reproduce it on earlier kernels?
