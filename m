Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA078AA33
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHLWMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 18:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfHLWMN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 18:12:13 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F54D2070C;
        Mon, 12 Aug 2019 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565647932;
        bh=dl+Tz0F8DICZ/Q3wJoeTdAyMirqmNwcwyPQV9GAFnro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyJMogyknyoe08H7Bmrmj4OuP47idleVZ9nmsE44pjssUABl7AANDVOe+mvolvwa3
         alHvFV/ehAkU8nh0mPOCUa4xm5CzoLSi6xY5nHx7Fo6J+Rf/4vZuzXfBgZ6WLMOIt7
         GPy5w0hxvYNJtKUTpcTpDZi5ziEiMQMo4TVcm1J8=
Date:   Mon, 12 Aug 2019 17:12:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: pciehp: Replace
 pciehp_green_led_{on,off,blink}()
Message-ID: <20190812221212.GF7302@google.com>
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-5-efremov@linux.com>
 <20190812200330.GH11785@google.com>
 <b948bc25-e643-a43c-de70-136a041f13b1@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b948bc25-e643-a43c-de70-136a041f13b1@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 13, 2019 at 12:14:08AM +0300, Denis Efremov wrote:
> > You must have a reason, but why didn't you completely remove
> > pciehp_green_led_on(), etc, and change the callers to use
> > pciehp_set_indicators() instead?
> 
> Well, I don't have the exact reason here. I thought that it would be nice to preserve
> an existing interface and to hide some implementation details (e.g., status of the
> second indicator). I could completely remove pciehp_green_led_{on,off,blink}() and
> pciehp_set_attention_status() in v3 if you prefer.

I might be missing something, but I do think I would prefer to
completely remove pciehp_green_led_{on,off,blink}() and
pciehp_set_attention_status().  Then we'd have exactly one interface
to change indicator state.
