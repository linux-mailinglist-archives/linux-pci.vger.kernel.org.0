Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C311E0C17
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbgEYKro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 06:47:44 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:50628 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKro (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 06:47:44 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 06:47:43 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 68D062808B4; Mon, 25 May 2020 12:37:59 +0200 (CEST)
Date:   Mon, 25 May 2020 12:37:59 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        f.fangjian@huawei.com, huangdaode@hisilicon.com
Subject: Re: [PATCH v7 0/2] pciutils: Add basic decode support for CXL DVSEC
Message-ID: <mj+md-20200525.103642.86045.nikam@ucw.cz>
References: <20200511174618.10589-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511174618.10589-1-sean.v.kelley@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

I applied your patch (by mistake, I applied v6 first, so the vendor ID change
is a separate commit).

I have cleaned up the code a bit, so that the DVSEC header is not parsed
multiple times.

Could you also update the cap-dvsec-cxl test to match the new vendor ID?

			Have a nice day
						Martin
