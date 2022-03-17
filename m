Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0E4DCD7E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 19:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiCQSYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 14:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiCQSYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 14:24:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083262CD
        for <linux-pci@vger.kernel.org>; Thu, 17 Mar 2022 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647541386; x=1679077386;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=F8sVzxqaf4ND6LVcGkU71OxLiFZI+kGo9l6P91PxKLU=;
  b=cu8+6UgKOeKKgOmgOcCStzd6GrlV1QwkGRu4XZTDPlGImoNqd/11ml+k
   /kSFyh5dhMd2c859OWNsVwvOOlaTDKh73cVF1KaGRm0OKHJzQA3xVbZmd
   yNcJdX3+phGugYG8FKTFReGOCKqHGF1xW6i9IiWcK8uTu1krLJLZhrXUu
   evD51+K6L+DthD1AadrFohYeJDG8xiLS4/9z0snF+3g7KGiWAjeoEz8+8
   ONu5Sr1/pWgEjH04giqe1ya8nHJPFnMZuVD8WjcYjzouaKO1IpZIcVM7l
   RKJGlkt52fxTDVaEn/s/Ki1SPdtHgejOfdpQCkezRfxXyzJNED+O5Ozox
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="239109793"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="239109793"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:23:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="558051484"
Received: from unknown (HELO localhost) ([10.252.58.37])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:23:03 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915: include uapi/drm/i915_drm.h
 directly where needed
In-Reply-To: <YjN02ff81NR8EPFI@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220311100639.114685-1-jani.nikula@intel.com>
 <20220311100639.114685-2-jani.nikula@intel.com>
 <YjN02ff81NR8EPFI@intel.com>
Date:   Thu, 17 Mar 2022 20:23:01 +0200
Message-ID: <87mthomoai.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Mar 2022, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Fri, Mar 11, 2022 at 12:06:39PM +0200, Jani Nikula wrote:
>> Remove the uapi/drm/i915_drm.h include from drm/i915_drm.h, and stop
>> being a proxy for uapi/drm/i915_drm.h. Include uapi/drm/i915_drm.h and
>> drm/i915_drm.h only where needed.
>>=20
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Looks sensible to me. Series is=20
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thanks for the review, pushed to drm-intel-next, with Bjorn's ack.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/i915/gem/i915_gem_lmem.c     | 2 ++
>>  drivers/gpu/drm/i915/gem/i915_gem_region.c   | 2 ++
>>  drivers/gpu/drm/i915/intel_memory_region.c   | 2 ++
>>  drivers/gpu/drm/i915/intel_memory_region.h   | 2 +-
>>  drivers/gpu/drm/i915/pxp/intel_pxp_session.c | 2 --
>>  include/drm/i915_drm.h                       | 2 +-
>>  6 files changed, 8 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_lmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_lmem.c
>> index 444f8268b9c5..ede084f36ca9 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_lmem.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_lmem.c
>> @@ -3,6 +3,8 @@
>>   * Copyright =C2=A9 2019 Intel Corporation
>>   */
>>=20=20
>> +#include <uapi/drm/i915_drm.h>
>> +
>>  #include "intel_memory_region.h"
>>  #include "gem/i915_gem_region.h"
>>  #include "gem/i915_gem_lmem.h"
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_region.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_region.c
>> index c9b2e8b91053..f4fbae2f9dcc 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_region.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_region.c
>> @@ -3,6 +3,8 @@
>>   * Copyright =C2=A9 2019 Intel Corporation
>>   */
>>=20=20
>> +#include <uapi/drm/i915_drm.h>
>> +
>>  #include "intel_memory_region.h"
>>  #include "i915_gem_region.h"
>>  #include "i915_drv.h"
>> diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/dr=
m/i915/intel_memory_region.c
>> index 1c841f68169a..ded78b83e0b5 100644
>> --- a/drivers/gpu/drm/i915/intel_memory_region.c
>> +++ b/drivers/gpu/drm/i915/intel_memory_region.c
>> @@ -5,6 +5,8 @@
>>=20=20
>>  #include <linux/prandom.h>
>>=20=20
>> +#include <uapi/drm/i915_drm.h>
>> +
>>  #include "intel_memory_region.h"
>>  #include "i915_drv.h"
>>  #include "i915_ttm_buddy_manager.h"
>> diff --git a/drivers/gpu/drm/i915/intel_memory_region.h b/drivers/gpu/dr=
m/i915/intel_memory_region.h
>> index 21dcbd620758..bbc35ec5c090 100644
>> --- a/drivers/gpu/drm/i915/intel_memory_region.h
>> +++ b/drivers/gpu/drm/i915/intel_memory_region.h
>> @@ -10,7 +10,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/io-mapping.h>
>>  #include <drm/drm_mm.h>
>> -#include <drm/i915_drm.h>
>> +#include <uapi/drm/i915_drm.h>
>>=20=20
>>  struct drm_i915_private;
>>  struct drm_i915_gem_object;
>> diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_session.c b/drivers/gpu/=
drm/i915/pxp/intel_pxp_session.c
>> index 598840b73dfa..92b00b4de240 100644
>> --- a/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
>> +++ b/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
>> @@ -3,8 +3,6 @@
>>   * Copyright(c) 2020, Intel Corporation. All rights reserved.
>>   */
>>=20=20
>> -#include <drm/i915_drm.h>
>> -
>>  #include "i915_drv.h"
>>=20=20
>>  #include "intel_pxp.h"
>> diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
>> index afbf3ef5643e..7adce327c1c2 100644
>> --- a/include/drm/i915_drm.h
>> +++ b/include/drm/i915_drm.h
>> @@ -26,7 +26,7 @@
>>  #ifndef _I915_DRM_H_
>>  #define _I915_DRM_H_
>>=20=20
>> -#include <uapi/drm/i915_drm.h>
>> +#include <linux/types.h>
>>=20=20
>>  /* For use by IPS driver */
>>  unsigned long i915_read_mch_val(void);
>> --=20
>> 2.30.2

--=20
Jani Nikula, Intel Open Source Graphics Center
