Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48AD20C91D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jun 2020 19:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgF1RCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jun 2020 13:02:47 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:53675 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1RCr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jun 2020 13:02:47 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2061328004EA1;
        Sun, 28 Jun 2020 19:02:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C2B8A5BA090; Sun, 28 Jun 2020 19:02:41 +0200 (CEST)
Date:   Sun, 28 Jun 2020 19:02:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Manish Raturi <raturi.manish@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: PCie Hot Plug query
Message-ID: <20200628170241.ljqft2ri36nhsgq4@wunner.de>
References: <CAHn-FMzcKbVY1H+bn+KKhO24QP1UpafEkj0PD_eCvnZWZ=fPSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHn-FMzcKbVY1H+bn+KKhO24QP1UpafEkj0PD_eCvnZWZ=fPSw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 28, 2020 at 09:53:51PM +0530, Manish Raturi wrote:
> For the hot-plug , if we disable the "Power Control Present" bit in
> slot capabilities register for the PCIE root port , then does it
> impact any hotplug functionality?

It should only result in Slot Power not being turned on when bringing up
the slot upon a DLLSC or PDC event (and off when bringing it down).
