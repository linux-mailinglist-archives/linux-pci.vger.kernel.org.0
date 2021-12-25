Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F047F352
	for <lists+linux-pci@lfdr.de>; Sat, 25 Dec 2021 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhLYNa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Dec 2021 08:30:59 -0500
Received: from smtp2.axis.com ([195.60.68.18]:14700 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhLYNa7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 25 Dec 2021 08:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1640439059;
  x=1671975059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s9lf9e/EduDxiaQQMklUM5VPoyo3fHkdFdUfVg0nmFY=;
  b=n6WQbkzwUcEFDpOWCoUEmg2leinzA4lfILfnxrhm3iLGeCUYeF20/zhK
   +GrW1dkxVRWIEAf3k4IOS6CetxiAIWwQ8ShrLojb9tGJgh7iOGrkze+oZ
   y/zHe4BediXVzvxVRxllfobsYDenec+qxGQ+OeYVf1Yqrlxb9Uf6LI9tH
   q3bCFyCkBsb+WSiazWvjKnUTCBjKzm/BbTxfXInwf5jGu2VGHityQ9hC3
   mHpnosqcxTIGjaOed+Y711f+tHkdWNDYNCaI85eVREm+FsrE+MvDktFSI
   IIuGNuW3MdrxWctPOgdfadEHx1qzcgdsAsUv3PR2G/NcMFFwAEDOlLgTE
   w==;
Date:   Sat, 25 Dec 2021 14:30:57 +0100
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>
Subject: Re: [PATCH v2 02/23] PCI: artpec6: Prefer of_device_get_match_data()
Message-ID: <20211225133057.GN5179@axis.com>
References: <20211223011054.1227810-1-helgaas@kernel.org>
 <20211223011054.1227810-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211223011054.1227810-3-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 23, 2021 at 02:10:33AM +0100, Bjorn Helgaas wrote:
> From: Fan Fei <ffclaire1224@gmail.com>
> 
> The artpec6 driver only needs the device data, not the whole struct
> of_device_id.  Use of_device_get_match_data() instead of of_match_device().
> No functional change intended.
> 
> [bhelgaas: commit log]
> Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me,

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: linux-arm-kernel@axis.com

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
