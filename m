Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5411F9940
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgFONq7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 09:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFONqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 09:46:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34BEC08C5C2
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 06:46:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l17so15696433qki.9
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5fbwAPFhj/t9OUXsbkBLa2lLyWbmpKqf/KaN0uZtDRI=;
        b=ed8Hh6W19/qv58dB6PJ+JDjl39VwebBT6j8EE97r3JHHDfwiJzt2hWVj16rCe6/VyG
         TGS6SE6ptiPexO04eKRNwcc2SavSPpI4Y+CNvCCPSLOeqvoWAFB5eirFpEK6+oB0wHHn
         YzrrGXXq34tALTQcvCQ5jV7jNVPV1gaoA7dxV+Ww8bCsTfAxqZWkLH2X+TRnp6v1UY/n
         5HvDJCpObIPTLoiUUvWm+Bh/6YdsUHOii7rZ0rTYrZCnagGu2eBunuySbs4KjAKcsich
         MHcryQhOUqxOkk25chIvq/NKjlr7ebKpn+uV5+YAUDcny6vx0EfBF5i2EahuqiwvnIGH
         ZLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5fbwAPFhj/t9OUXsbkBLa2lLyWbmpKqf/KaN0uZtDRI=;
        b=gKcTR6uQCGQnxL+VdVvc99qAC2+GeCL/g55H67Y/JCKGCQdcxNDybca0tCi7qE3OTU
         BoDx5/Fmr+y1i1JwtTnF/POAkHKvqTJOU89Rn9Yj9ZtZKlzEcTIO0Chzy57n16njDGQL
         yQ7noO7RG3yNITDGz3Bjpq508TzM7Wqyet7Ikta0wKkTAFXEPJBB5Y8FMhULhUrfUNnG
         xXoFYgm3hZYVCn/9ehN4eOMK5qoa2Id4spMs3Hrr8IliNJypQ2SOGZ8Yczwhh7GLs3LE
         KPQx+iRcgJD4D0dEzGFVLQTtm7xOMUojg2j1l6kLxSSCUG4MwkInch+BvZ0tfob0o2tS
         9R+Q==
X-Gm-Message-State: AOAM533QtwfzxsemPWQz7ztVmqucS80mvNegEH+pn1xYiMw/oPuEujRN
        irvSRZM9AnieHVhPS4SVxUK8LA==
X-Google-Smtp-Source: ABdhPJySxHjK9XxwDJnFQN4DvhgJhASkwz/NHGoO8h3oIBKNCRR+t8iWEXyH5O1Z018vigBdL2M9HQ==
X-Received: by 2002:a37:bfc1:: with SMTP id p184mr15321144qkf.207.1592228811377;
        Mon, 15 Jun 2020 06:46:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 124sm10100237qkn.45.2020.06.15.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 06:46:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jkpRq-008aTM-EI; Mon, 15 Jun 2020 10:46:50 -0300
Date:   Mon, 15 Jun 2020 10:46:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     refactormyself@gmail.com
Cc:     helgaas@kernel.org, bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8 v2] PCI: Align return values of PCIe capability and
 PCI accessors
Message-ID: <20200615134650.GA2030477@ziepe.ca>
References: <20200615073225.24061-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 09:32:17AM +0200, refactormyself@gmail.com wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> 
> PATCH 1/8 to 7/8:
> PCIBIOS_ error codes have positive values and they are passed down the
> call heirarchy from accessors. For functions which are meant to return
> only a negative value on failure, passing on this value is a bug.
> To mitigate this, call pcibios_err_to_errno() before passing on return
> value from PCIe capability accessors call heirarchy. This function
> converts any positive PCIBIOS_ error codes to negative generic error
> values.
> 
> PATCH 8/8:
> The PCIe capability accessors can return 0, -EINVAL, or any PCIBIOS_ error
> code. The pci accessor on the other hand can only return 0 or any PCIBIOS_
> error code.This inconsistency among these accessor makes it harder for
> callers to check for errors.
> Return PCIBIOS_BAD_REGISTER_NUMBER instead of -EINVAL in all PCIe
> capability accessors.
> 
> MERGING:
> These may all be merged via the PCI tree, since it is a collection of
> similar fixes. This way they all get merged at once.

I prefer this not happen for active trees, it just risks needless
merge conflicts.

I will take the hfi1 patches at least, let me know when they are
reviewed

Thanks,
Jason
