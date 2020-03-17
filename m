Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9016189222
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 00:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgCQX2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 19:28:31 -0400
Received: from mail.rc.ru ([151.236.222.147]:50592 "EHLO mail.rc.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbgCQX2b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 19:28:31 -0400
Received: from mail.rc.ru ([2a01:7e00:e000:1bf::1]:39756)
        by mail.rc.ru with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ink@jurassic.park.msu.ru>)
        id 1jELdK-0001ce-QW; Tue, 17 Mar 2020 23:28:26 +0000
Date:   Tue, 17 Mar 2020 23:28:25 +0000
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] alpha: fix nautilus PCI setup
Message-ID: <20200317232825.GA6018@mail.rc.ru>
References: <20200314194745.GB12510@mail.rc.ru>
 <CAEdQ38GP8XJpgaWRZKFVpHY1mYGh2oaQnnBPYH86tbCRc=U_Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdQ38GP8XJpgaWRZKFVpHY1mYGh2oaQnnBPYH86tbCRc=U_Xg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 16, 2020 at 11:26:24PM -0700, Matt Turner wrote:
> One thing I noticed: this variable is now no longer used.

Right, my fault. I think it would be better to re-submit
the nautilus part, will do that shortly.

Ivan.
