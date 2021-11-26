Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF7245F34A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhKZSDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbhKZSBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 13:01:18 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52716C061746;
        Fri, 26 Nov 2021 09:35:06 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 56333102EF244;
        Fri, 26 Nov 2021 18:35:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2EC35294C4B; Fri, 26 Nov 2021 18:35:04 +0100 (CET)
Date:   Fri, 26 Nov 2021 18:35:04 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed
 in polling mode
Message-ID: <20211126173504.GA25721@wunner.de>
References: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
 <20211126173309.GA12255@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126173309.GA12255@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 26, 2021 at 06:33:09PM +0100, Lukas Wunner wrote:
> Cc: stable@vger.kernel.org # v4.19+

Sorry, I meant v4.2+.
