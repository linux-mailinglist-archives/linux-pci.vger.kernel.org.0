Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8988972A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 08:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfHLGcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 02:32:02 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:50767 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfHLGcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 02:32:02 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D10B1100D9401;
        Mon, 12 Aug 2019 08:32:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8775210D98; Mon, 12 Aug 2019 08:32:00 +0200 (CEST)
Date:   Mon, 12 Aug 2019 08:32:00 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: pciehp: Replace pciehp_set_attention_status()
Message-ID: <20190812063200.4ngzswfvbt3gr2mx@wunner.de>
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-4-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811195944.23765-4-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 10:59:43PM +0300, Denis Efremov wrote:
> +#define pciehp_set_attention_status(ctrl, status) \
> +	pciehp_set_indicators(ctrl, PWR_NONE, (status == 0 ? ATTN_OFF : status))

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Good catch regarding the translation of the "off" value that's needed here.
