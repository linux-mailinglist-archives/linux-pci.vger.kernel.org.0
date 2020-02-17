Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C59C16147A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 15:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgBQOXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 09:23:36 -0500
Received: from verein.lst.de ([213.95.11.211]:34035 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgBQOXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Feb 2020 09:23:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CBC4568B05; Mon, 17 Feb 2020 15:23:33 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:23:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20200217142333.GA28421@lst.de>
References: <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com> <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com> <20200205074719.GA22701@lst.de> <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com> <20200205084844.GA23831@lst.de> <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com> <20200205091959.GA24413@lst.de> <9be3bed4-3804-1b3e-a91a-ed52407524ce@ti.com> <20200205160542.GA30981@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205160542.GA30981@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 05:05:42PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 05, 2020 at 03:03:13PM +0530, Kishon Vijay Abraham I wrote:
> > Yes, I see the mismatch after reverting the above patches.
> 
> In which case the data mismatch is very likely due to a different root
> cause.

Did you manage to dig into this a little more?
