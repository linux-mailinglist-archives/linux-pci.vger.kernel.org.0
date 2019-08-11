Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1228689294
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKQ32 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 12:29:28 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:42661 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfHKQ32 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 12:29:28 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 51C7C100D9405;
        Sun, 11 Aug 2019 18:29:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 177D6233E81; Sun, 11 Aug 2019 18:29:26 +0200 (CEST)
Date:   Sun, 11 Aug 2019 18:29:25 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI: pciehp: Replace
 pciehp_green_led_{on,off,blink}()
Message-ID: <20190811162925.t3svkhswsplvvnfq@wunner.de>
References: <20190811132945.12426-1-efremov@linux.com>
 <20190811132945.12426-5-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811132945.12426-5-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 04:29:45PM +0300, Denis Efremov wrote:
> This patch replaces pciehp_green_led_{on,off,blink}() with
> pciehp_set_indicators().
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
