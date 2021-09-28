Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0B441B2BA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 17:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbhI1PQf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 11:16:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:6373 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241405AbhI1PQe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="247235504"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="247235504"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 08:01:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="478724733"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.51])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 08:01:46 -0700
Date:   Tue, 28 Sep 2021 16:01:32 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Marco Chiappero <marco.chiappero@intel.com>,
        linux-pci@vger.kernel.org, qat-linux@intel.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 6/8] crypto: qat - simplify adf_enable_aer()
Message-ID: <YVMuTMMzPSyCBSVS@silpixa00400314>
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
 <20210927204326.612555-7-uwe@kleine-koenig.org>
 <YVL4aoKjUT2kvHip@silpixa00400314>
 <20210928112637.kolit6fusme7g2qf@pengutronix.de>
 <20210928135704.oqyffwwt4lvmmlx3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928135704.oqyffwwt4lvmmlx3@pengutronix.de>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 28, 2021 at 03:57:04PM +0200, Uwe Kleine-König wrote:
> I fixed it now, comparing with your patch the only thing I did
> differently is ordering in the header file.
> 
> I pushed the fixed series to
> 
> 	https://git.pengutronix.de/git/ukl/linux pci-dedup
Would you mind sending the new version to the ML?

Thanks,

-- 
Giovanni
