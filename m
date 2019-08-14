Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9B8CAAA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 07:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHNFis (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 01:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfHNFir (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 01:38:47 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F1F20843;
        Wed, 14 Aug 2019 05:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565761127;
        bh=jbQInFjWCcnVxKfc7U99XY9coODUEn+idyykG/S6etY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=icdZw5dkw+xB/68m0F5VIkcHS3Y562JhnitWRYAyJO34yBtO33gj97J174/RmaIJt
         dbZ1PZiVsvSgZx/H2yVa7EBKekeVS+XijvnYi8OW65ae/y/vVWE6rTCCwf6SiDlGZe
         cUqjjXSjXzrDgboNIx2F5lusPtozsD86EjiZ7rIE=
Date:   Wed, 14 Aug 2019 00:38:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>,
        Donald Dutile <ddutile@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Linux-kernel-mentees] [PATCH v2 2/3] PCI: sysfs: Change
 permissions from symbolic to octal
Message-ID: <20190814053846.GA253360@google.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-3-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813204513.4790-3-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Bodong, Don, Greg for permission question]

On Tue, Aug 13, 2019 at 02:45:12PM -0600, Kelsey Skunberg wrote:
> Symbolic permissions such as "(S_IWUSR | S_IWGRP)" are not
> preferred and octal permissions should be used instead. Change all
> symbolic permissions to octal permissions.
> 
> Example of old:
> 
> "(S_IWUSR | S_IWGRP)"
> 
> Example of new:
> 
> "0220"


>  static DEVICE_ATTR_RO(sriov_totalvfs);
> -static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> -				  sriov_numvfs_show, sriov_numvfs_store);
> +static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
>  static DEVICE_ATTR_RO(sriov_offset);
>  static DEVICE_ATTR_RO(sriov_stride);
>  static DEVICE_ATTR_RO(sriov_vf_device);
> -static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> -		   sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> +static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> +		   sriov_drivers_autoprobe_store);

Greg noticed that sriov_numvfs and sriov_drivers_autoprobe have
"unusual" permissions.  These were added by:

  0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
  1789382a72a5 ("PCI: SRIOV control and status via sysfs")

Kelsey's patch correctly preserves the existing permissions, but we
should double-check that they are the permissions they want, and
possibly add a comment about why they're different from the rest.

Bjorn
