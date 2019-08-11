Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7A8929F
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfHKQcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 12:32:41 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:60483 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfHKQcl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 12:32:41 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1E19E100D9405;
        Sun, 11 Aug 2019 18:32:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C3E8F233E8B; Sun, 11 Aug 2019 18:32:38 +0200 (CEST)
Date:   Sun, 11 Aug 2019 18:32:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: pciehp: Add pciehp_set_indicators() to jointly
 set LED indicators
Message-ID: <20190811163238.aimwkiqfklckbond@wunner.de>
References: <20190811132945.12426-1-efremov@linux.com>
 <20190811132945.12426-2-efremov@linux.com>
 <20190811160755.w2jpcqt2powdcz7q@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811160755.w2jpcqt2powdcz7q@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 06:07:55PM +0200, Lukas Wunner wrote:
> 	if (!PWR_LED(ctrl)  || pwr  == PWR_NONE) &&
> 	    !ATTN_LED(ctrl) || attn == ATTN_NONE))
> 		return;

Forgot an opening brace in two spots here, sorry.
