Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9F54A4679
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 12:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiAaL7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 06:59:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:20365 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345119AbiAaL7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 06:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643630365; x=1675166365;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UkuC7imNZRlOXaUyo+gIGZVLZckIxwvd/nKkmVQfZwU=;
  b=boHcLUVCT/vW81Hj5ledvIopLYqzEn7a0+0Kd+P6jy+ZfptLgo+o1bmF
   1B00e4n9qEmLDf/trAg/K8U1Rj9LpgT+WpUdQ7aECoI0GtZzUUibx7UUP
   6OnWBPPCTdFe9Q9Z1U5osmkbEVkdQQ2KcK6CqwgNzE8bngNITKVMnmzUl
   nHHzxtBab2LWzhPqpVHgG/Ov1d7db30JX4Nhv+uDeo1of3CayGX1FhJh0
   Q5I8SkJyEfPOTHWlYmiCRGtMixB5Tw0D5zQpA/JJD4yyBaLHZ1yYwZU3t
   gdPKHXXt0sPodQVLqGj4FDziM6GH/qpUbPAYS3kD7syY2hq5oYhmGypNk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="227416740"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="227416740"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:59:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="537151087"
Received: from mtkaczyk-mobl1.ger.corp.intel.com (HELO localhost) ([10.213.29.132])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:59:20 -0800
Date:   Mon, 31 Jan 2022 12:59:15 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        helgaas@kernel.org, lukas@wunner.de, pavel@ucw.cz,
        linux-cxl@vger.kernel.org, martin.petersen@oracle.com,
        James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 2/3] Add PCIe enclosure management auxiliary driver
Message-ID: <20220131125915.0000294f@linux.intel.com>
In-Reply-To: <111e1684ab4a77c7ca4abc9f7fd1f37f9534d937.1642460765.git.stuart.w.hayes@gmail.com>
References: <cover.1642460765.git.stuart.w.hayes@gmail.com>
        <111e1684ab4a77c7ca4abc9f7fd1f37f9534d937.1642460765.git.stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stuart,
On Mon, 17 Jan 2022 22:17:57 -0600
Stuart Hayes <stuart.w.hayes@gmail.com> wrote:

> +	switch (output->status) {
> +	case 0:
> +		break;
> +	case 1:
> +		pci_dbg(pdev, "_DSM not supported\n");
> +		break;
> +	case 2:
> +		pci_dbg(pdev, "_DSM invalid input parameters\n");
> +		break;
> +	case 3:
> +		pci_dbg(pdev, "_DSM communication error\n");
> +		break;
> +	case 4:
> +		pci_dbg(pdev, "_DSM function-specific error 0x%x\n",
> +			output->function_specific_err);
> +		break;
> +	case 5:
> +		pci_dbg(pdev, "_DSM vendor-specific error 0x%x\n",
> +			output->vendor_specific_err);
> +		break;
> +	default:
> +		pci_dbg(pdev, "_DSM returned unknown status 0x%x\n",
> +			output->status);
> +	}
> +}

I tired to compile it and I failed:
drivers/misc/enclosure.c: In function =E2=80=98led_show=E2=80=99:
drivers/misc/enclosure.c:607:3: error: label at end of compound
statement default:
   ^~~~~~~
drivers/misc/enclosure.c: In function =E2=80=98led_set=E2=80=99:
drivers/misc/enclosure.c:644:3: error: label at end of compound
statement default:
   ^~~~~~~
make[2]: *** [scripts/Makefile.build:288: drivers/misc/enclosure.o]
Error 1 make[1]: *** [scripts/Makefile.build:550: drivers/misc] Error 2
make[1]: *** Waiting for unfinished jobs....

My gcc version:
gcc (SUSE Linux) 7.5.0

Could you please, resolve the issue?

Thanks,
Mariusz
