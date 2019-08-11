Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA06689290
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 18:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfHKQ2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 12:28:05 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:50219 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfHKQ2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 12:28:05 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4F3AB100D9405;
        Sun, 11 Aug 2019 18:28:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 042CA23EF70; Sun, 11 Aug 2019 18:28:02 +0200 (CEST)
Date:   Sun, 11 Aug 2019 18:28:02 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI: pciehp: Replace pciehp_set_attention_status()
Message-ID: <20190811162802.hgiiojl5rbvr7tvu@wunner.de>
References: <20190811132945.12426-1-efremov@linux.com>
 <20190811132945.12426-4-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811132945.12426-4-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 04:29:44PM +0300, Denis Efremov wrote:
> +#define pciehp_set_attention_status(crtl, status) \
> +	pciehp_set_indicators(ctrl, PWR_NONE, status)
> +

There's a typo here, s/crtl/ctrl/.

With that addressed,

Reviewed-by: Lukas Wunner <lukas@wunner.de>
