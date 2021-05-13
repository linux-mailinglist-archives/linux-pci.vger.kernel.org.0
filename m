Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74DC37FB3C
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhEMQJ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 12:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235030AbhEMQJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 12:09:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDDF86142E;
        Thu, 13 May 2021 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620922127;
        bh=6eFyRHlN9Nei3oCzsnoGykRm4FcRWq7r2LHmZfe4qEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvWznWEtYCM71Wo36CrNXn/wrRidnlnIDIOneWM4hgabhLRip4tq4ic63thiVKNBh
         crJ4cAZH5An/Wf69im1wAE/9PfABSpTt/NOzNMXfwlz+b0L5/UmSB6jqo2g2aR/RNa
         Q7GXQPPUun7jyrU9IwjtHwI9y7HnzcH/ZBNX4EW9FlYWkq2c9GKFJEYmdAQ3yR81Gl
         rx5zuLaftjXaN8CWnECGEQWQQ/FR2dJunRfHh4Jj0GAoaWr/akMkVyc5aaboWH2vlm
         ilhXox8Cvyh2IuTh80N9BF+EL/GbJUNO0OaubDZYZ2upqa8F8LPbFcZO13SXqgqAI5
         NmMsFy6ACVcFg==
Date:   Thu, 13 May 2021 09:08:44 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "linux.enthusiast" <linux.enthusiast@protonmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: How does the "/sys/bus/pci/drivers/*/*" interface work?
Message-ID: <20210513160844.GC2272284@dhcp-10-100-145-180.wdc.com>
References: <bO6tTSRbjFucyxFz_SsgnnkT6H40xY428tQCVi64ig-N6nVg_xxyHzjb7m31oMu0VRSDjMRt9DdH3jMg7sefDSmx-XEyh-Htr3x9o6AU3hk=@protonmail.com>
 <20210513144650.GA2272206@dhcp-10-100-145-180.wdc.com>
 <CTXLhLhp53xP5tJrXVibXRGGcF5MG4zpXCnmm_NkF-3GbkH6nC9JpkqLtfeEXfTKV8JJgKsdyaG35rJhMbofPADFCIhdTHWXqC2DEqxdsfU=@protonmail.com>
 <20210513153523.GA2272284@dhcp-10-100-145-180.wdc.com>
 <rESCSH2fnmwIxIMl_DQVwjbn5Ib5Iu_TM5kAhRJb6L7Yy4QCbNIrgccFFWIsx1LI-VmcG5SGJQpxscE3LxClwKMbUSj4Qm9ILcj-prLAkNI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rESCSH2fnmwIxIMl_DQVwjbn5Ib5Iu_TM5kAhRJb6L7Yy4QCbNIrgccFFWIsx1LI-VmcG5SGJQpxscE3LxClwKMbUSj4Qm9ILcj-prLAkNI=@protonmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 03:58:01PM +0000, linux.enthusiast wrote:
> On Thursday, May 13, 2021 5:35 PM, Keith Busch <kbusch@kernel.org> wrote:
> > Run 'modinfo <name-of-driver>'. For pci drivers, each "alias" line will
> > show some kind of pci information that the driver binds to.
> 
> Thank you, unfortunately there are no `alias` entries or any other entries that contain the ID that I dynamically added for the driver I'm looking at (vfio-pci). Maybe this approach only works for the IDs the driver has by default, not the ones added dynamically via `new_id`?

Yes, modinfo shows devices the driver has built-in binding. vfio-pci
doesn't bind to anything by default, so nothing there.

It doesn't look like the kernel provides a way to report a list of
dynamically assigned ids.
