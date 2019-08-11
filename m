Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570BF8927F
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHKQLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 12:11:34 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46585 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHKQLe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 12:11:34 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 478A630000CC0;
        Sun, 11 Aug 2019 18:11:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1AA0F233EB3; Sun, 11 Aug 2019 18:11:32 +0200 (CEST)
Date:   Sun, 11 Aug 2019 18:11:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: pciehp: Switch LED indicators with a single
 write
Message-ID: <20190811161132.tuofkt5jefqd7fs4@wunner.de>
References: <20190811132945.12426-1-efremov@linux.com>
 <20190811132945.12426-3-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811132945.12426-3-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 04:29:43PM +0300, Denis Efremov wrote:
> This patch replaces all consecutive switches of power and attention
> indicators with pciehp_set_indicators() call. Thus, performing only
> single write to a register.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
