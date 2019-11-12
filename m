Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3035CF965A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKLQz7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 11:55:59 -0500
Received: from mail.netline.ch ([148.251.143.178]:42025 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfKLQxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2019 11:53:25 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 11:53:24 EST
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id E45422A6046;
        Tue, 12 Nov 2019 17:45:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id IU3ZG7YC6ovU; Tue, 12 Nov 2019 17:45:17 +0100 (CET)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id DF2832A6045;
        Tue, 12 Nov 2019 17:45:16 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.93-RC1)
        (envelope-from <michel@daenzer.net>)
        id 1iUZI3-0007oQ-QX; Tue, 12 Nov 2019 17:45:15 +0100
Subject: Re: [PATCH 1/2] drm: replace incorrect Compliance/Margin magic
 numbers with PCI_EXP_LNKCTL2 definitions
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20191111192932.36048-1-helgaas@kernel.org>
 <20191111192932.36048-2-helgaas@kernel.org>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <6d86246e-504a-b762-aff8-0449dd6f3d31@daenzer.net>
Date:   Tue, 12 Nov 2019 17:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111192932.36048-2-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-11-11 8:29 p.m., Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add definitions for these PCIe Link Control 2 register fields:
> 
>   Enter Compliance
>   Transmit Margin
> 
> and use them in amdgpu and radeon.
> 
> NOTE: This is a functional change because "7 << 9" was apparently a typo.
> That mask included the high order bit of Transmit Margin, the Enter
> Modified Compliance bit, and the Compliance SOS bit, but I think what
> was intended was the 3-bit Transmit Margin field at bits 9:7.

Can you split out the functional change into a separate patch 1? That
could make things easier for anyone who bisects the functional change
for whatever reason.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
