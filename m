Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4576029DD00
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 01:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbgJ1WUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:20:34 -0400
Received: from smtp1.axis.com ([195.60.68.17]:65154 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732202AbgJ1WUc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:20:32 -0400
X-Greylist: delayed 2240 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 18:20:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=411; q=dns/txt; s=axis-central1;
  t=1603923632; x=1635459632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6nefk6qLvt2N+SlLRUmIvEhqqqWIvL3vPC/cV/yIqI=;
  b=Rm7dqi0a+1dTvT6nF7qy+i4ELRnE6CsIVo6xIWrP+/HBY6OyvFxXOYyM
   uHbqkkmpg7Wf1qTPsxKECvOgelORfJavN24xRHKb/nCOHlGTCkiU2sZKP
   TdOMi96uSIde9xzznXlsuwSDdnUadfDAxhdAQaBCeejsXvZaDhNV0iBpB
   ZPAh8pqhVljS8iYUIpM3Us0NTyfLkrqQGrgh4NM/tX+L8c/f4AL7PTb6o
   Wn+BaaFY+zhnt4AwTqqvwdXHm+Wlt4M7Vc4yh43oVI493siNolA9UEugc
   6OaZNHGyNZ+gaKxF4mQBdMuK0NIQ9tUp48zbjr6aOY0DNv1aF/eOZcIrs
   g==;
IronPort-SDR: 3D9ztP36IlKFWadXfPM2MkLYOmGgK6qkHF7krwn55t2zdK/xtPPl6hkHJkP3JGlYrpKB+xHsE1
 K7Kck1EhEA4kXyPvY+VPbVVn3GuywioinswjVdu1WAJ/0zrFOBrEtfE7LoLJjKSi/1GqlhnOI/
 xcW444Vdi0+CBtbTRa8xQUqYDagFcN9y1n6JtkjADQH9xgchGaFEsvhAJ1x31Al8qruyquFM3o
 hRh9JX8FG6yOd7W4Q9sOhWnDqQEbPU68yB2w758jd4b78+z5Vag9bnbdRYoMkFB0GtY/dCeGLX
 5eY=
X-IronPort-AV: E=Sophos;i="5.77,425,1596492000"; 
   d="scan'208";a="14495663"
Date:   Wed, 28 Oct 2020 10:09:20 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg KH <gregkh@linuxfoundation.org>, <sudeep.dutt@intel.com>
CC:     Sherry Sun <sherry.sun@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "fugang.duan@nxp.com" <fugang.duan@nxp.com>
Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to dma
 coherent memory
Message-ID: <20201028090920.xaryai7bnknxphqf@axis.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
 <20201028055836.GA244690@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201028055836.GA244690@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 06:58:36AM +0100, Greg KH wrote:
> Have you all seen:
> 	https://lore.kernel.org/r/8c1443136563de34699d2c084df478181c205db4.1603854416.git.sudeep.dutt@intel.com

No, that link doesn't work and I can't find that email from Sudeep in
any of the archives:

 https://lore.kernel.org/lkml/?q=f%3Asudeep.dutt%40intel.com

Sudeep, perhaps you could try to resend the patch?  Thank you.
