Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44CA1FCA5B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQKCJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 Jun 2020 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQKCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 06:02:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDA9C061573
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 03:02:09 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlUtO-0004qU-NR; Wed, 17 Jun 2020 12:02:02 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlUtN-0004hz-Dk; Wed, 17 Jun 2020 12:02:01 +0200
Message-ID: <c1ccb77ef0bc56b96a8ad991f8345d0ffbd76fc2.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/9] reset: Add Raspberry Pi 4 firmware reset
 controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com
Date:   Wed, 17 Jun 2020 12:02:01 +0200
In-Reply-To: <20200612171334.26385-3-nsaenzjulienne@suse.de>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
         <20200612171334.26385-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

On Fri, 2020-06-12 at 19:13 +0200, Nicolas Saenz Julienne wrote:
> Raspberry Pi 4's co-processor controls some of the board's HW
> initialization process, but it's up to Linux to trigger it when
> relevant. Introduce a reset controller capable of interfacing with
> RPi4's co-processor that models these firmware initialization routines as
> reset lines.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

If there is a good reason for the single DT specified reset id, I can
pick up patches 1 and 2.

If you change the dts patch 4 to use a number instead of the reset id
define for now, there wouldn't even be a dependency between these reset
and dts patches.

regards
Philipp
